import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/features/home/domain/entity/post_entity.dart';
import 'package:instai/features/home/domain/repositories/home_repositories.dart';

class GetPostsUsecase {
  const GetPostsUsecase(HomeRepository repository) : _repository = repository;

  final HomeRepository _repository;

  Future<Either<Failure, List<PostEntity>>> call() async {
    return await _repository.getPosts();
  }
}
