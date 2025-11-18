import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/features/post/domain/entities/generate_post_params_entity.dart';
import 'package:instai/features/post/domain/entities/generated_post_entity.dart';
import 'package:instai/features/post/domain/repositories/post_repository.dart';

class GeneratePostUsecase {
  const GeneratePostUsecase(this._repository);

  final PostRepository _repository;

  Future<Either<Failure, GeneratedPostEntity>> call(
    GeneratePostParamsEntity params,
  ) {
    return _repository.generatePost(params);
  }
}


