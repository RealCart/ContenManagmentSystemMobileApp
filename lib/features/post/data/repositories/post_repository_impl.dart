import 'package:dio/dio.dart';
import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/features/post/data/sources/remote/post_remote.dart';
import 'package:instai/features/post/domain/entities/generate_post_params_entity.dart';
import 'package:instai/features/post/domain/entities/generated_post_entity.dart';
import 'package:instai/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  const PostRepositoryImpl({required PostRemote remote}) : _remote = remote;

  final PostRemote _remote;

  @override
  Future<Either<Failure, GeneratedPostEntity>> generatePost(
    GeneratePostParamsEntity params,
  ) async {
    try {
      final response = await _remote.generatePost(
        photoFile: params.photoFile,
        description: params.description,
        hashtags: params.hashtags,
        size: params.size,
      );
      return Either.right(response.toEntity());
    } on DioException catch (e) {
      return Either.left(e.error as Failure);
    }
  }

  @override
  Future<Either<Failure, bool>> saveGeneratedPost(
    GeneratedPostEntity entity,
  ) async {
    try {
      await _remote.saveGeneratedPost(
        generatedDescription: entity.generatedDescription,
        originalDescription: entity.originalDescription,
        hashtags: entity.hashtags,
        tempPhotoPath: entity.tempPhotoPath,
        size: entity.size,
      );
      return Either.right(true);
    } on DioException catch (e) {
      return Either.left(e.error as Failure);
    }
  }
}


