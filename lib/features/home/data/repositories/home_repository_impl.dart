import 'package:dio/dio.dart';
import 'package:instai/core/utils/either.dart';
import 'package:instai/core/utils/failure.dart';
import 'package:instai/features/home/data/sources/remote/home_remote.dart';
import 'package:instai/features/home/domain/entity/post_entity.dart';
import 'package:instai/features/home/domain/entity/user_enttiy.dart';
import 'package:instai/features/home/domain/repositories/home_repositories.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({required HomeRemote remote}) : _remote = remote;

  final HomeRemote _remote;

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async {
    try {
      final response = await _remote.getPosts();

      final data = response.map((e) => e.toEntity()).toList();

      return Either.right(data);
    } on DioException catch (e) {
      return Either.left(e.error as Failure);
    }
  }

  @override
  Future<Either<Failure, UserEnttiy>> getUserInfo() async {
    try {
      final response = await _remote.getUserInfo();

      return Either.right(response.toEntity());
    } on DioException catch (e) {
      return Either.left(e.error as Failure);
    }
  }

  @override
  Future<Either<Failure, bool>> deletePost(int id) async {
    try {
      await _remote.deletePost(id);
      return Either.right(true);
    } on DioException catch (e) {
      return Either.left(e.error as Failure);
    }
  }
}
