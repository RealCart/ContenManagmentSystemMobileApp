import 'package:instai/core/constants/app_api.dart';
import 'package:instai/core/data/sources/remote/http_client.dart';
import 'package:instai/features/home/data/models/post_model.dart';
import 'package:instai/features/home/data/models/user_model.dart';

abstract interface class HomeRemote {
  Future<UserModel> getUserInfo();
  Future<List<PostModel>> getPosts();
  Future<void> deletePost(int id);
}

class HomeRemoteImpl implements HomeRemote {
  const HomeRemoteImpl(HttpClient http) : _http = http;

  final HttpClient _http;

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await _http.get(AppApi.posts);

    return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
  }

  @override
  Future<UserModel> getUserInfo() async {
    final response = await _http.get(AppApi.usersMe);

    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> deletePost(int id) async {
    await _http.delete("${AppApi.posts}/$id");
  }
}
