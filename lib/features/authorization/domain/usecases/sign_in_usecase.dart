import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/features/authorization/domain/entities/form_params_entity.dart';
import 'package:instai/features/authorization/domain/repositories/auth_repository.dart';

class SignInUsecase {
  const SignInUsecase(AuthRepository repository) : _repository = repository;

  final AuthRepository _repository;

  Future<Either<Failure, bool>> call(FormParamsEntity params) async {
    return await _repository.signInUser(params);
  }
}
