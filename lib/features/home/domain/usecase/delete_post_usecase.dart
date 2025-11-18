import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/features/home/domain/repositories/home_repositories.dart';

class DeletePostUsecase {
  const DeletePostUsecase(this._repository);

  final HomeRepository _repository;

  Future<Either<Failure, bool>> call(int id) {
    return _repository.deletePost(id);
  }
}


