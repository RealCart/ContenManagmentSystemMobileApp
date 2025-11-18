import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/features/home/domain/entity/post_entity.dart';
import 'package:instai/features/home/domain/entity/user_enttiy.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, UserEnttiy>> getUserInfo();
  Future<Either<Failure, List<PostEntity>>> getPosts();
  Future<Either<Failure, bool>> deletePost(int id);
}
