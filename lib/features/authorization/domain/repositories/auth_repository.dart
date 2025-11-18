import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/features/authorization/domain/entities/form_params_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, bool>> signUpUser(FormParamsEntity params);
  Future<Either<Failure, bool>> signInUser(FormParamsEntity params);
}
