import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/features/post/domain/entities/generate_post_params_entity.dart';
import 'package:instai/features/post/domain/entities/generated_post_entity.dart';

abstract interface class PostRepository {
  Future<Either<Failure, GeneratedPostEntity>> generatePost(
    GeneratePostParamsEntity params,
  );
  Future<Either<Failure, bool>> saveGeneratedPost(
    GeneratedPostEntity entity,
  );
}


