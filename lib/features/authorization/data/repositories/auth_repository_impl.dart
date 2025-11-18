import 'package:dio/dio.dart';
import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/features/authorization/data/models/form_params_model.dart';
import 'package:instai/core/data/sources/locale/token_storage.dart';
import 'package:instai/features/authorization/data/sources/remote/auth_remote.dart';
import 'package:instai/features/authorization/domain/entities/form_params_entity.dart';
import 'package:instai/features/authorization/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemote remote,
    required TokenStorage token,
  }) : _remote = remote,
       _tokenStorage = token;

  final AuthRemote _remote;
  final TokenStorage _tokenStorage;

  @override
  Future<Either<Failure, bool>> signInUser(FormParamsEntity params) async {
    try {
      final response = await _remote.signInUser(
        FormParamsModel.fromEntity(params),
      );

      _tokenStorage.writeToken(response.token);

      return Either.right(true);
    } on DioException catch (e) {
      return Either.left(e.error as Failure);
    }
  }

  @override
  Future<Either<Failure, bool>> signUpUser(FormParamsEntity params) async {
    try {
      final response = await _remote.signUpUser(
        FormParamsModel.fromEntity(params),
      );

      _tokenStorage.writeToken(response.token);

      return Either.right(true);
    } on DioException catch (e) {
      return Either.left(e.error as Failure);
    }
  }
}
