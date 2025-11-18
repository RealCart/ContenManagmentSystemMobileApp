import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/features/post/domain/entities/generated_post_entity.dart';
import 'package:instai/features/post/domain/repositories/post_repository.dart';

class SavePostUsecase {
  const SavePostUsecase(this._repository);

  final PostRepository _repository;

  Future<Either<Failure, bool>> call(GeneratedPostEntity entity) {
    return _repository.saveGeneratedPost(entity);
  }
}


