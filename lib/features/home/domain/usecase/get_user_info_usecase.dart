import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/features/home/domain/entity/user_enttiy.dart';
import 'package:instai/features/home/domain/repositories/home_repositories.dart';

class GetUserInfoUsecase {
  const GetUserInfoUsecase(HomeRepository repository)
    : _repository = repository;

  final HomeRepository _repository;

  Future<Either<Failure, UserEnttiy>> call() async {
    return await _repository.getUserInfo();
  }
}
