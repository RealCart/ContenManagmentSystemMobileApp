import 'dart:io';

import 'package:dio/dio.dart';
import 'package:instai/core/constants/app_api.dart';
import 'package:instai/core/data/sources/remote/http_client.dart';
import 'package:instai/features/post/data/models/generated_post_model.dart';

abstract interface class PostRemote {
  Future<GeneratedPostModel> generatePost({
    File? photoFile,
    required String description,
    required List<String> hashtags,
    required String size,
  });
  Future<void> saveGeneratedPost({
    required String generatedDescription,
    required String originalDescription,
    required String hashtags,
    required String? tempPhotoPath,
    required String size,
  });
}

class PostRemoteImpl implements PostRemote {
  const PostRemoteImpl(HttpClient http) : _http = http;

  final HttpClient _http;

  @override
  Future<GeneratedPostModel> generatePost({
    File? photoFile,
    required String description,
    required List<String> hashtags,
    required String size,
  }) async {
    final formMap = <String, dynamic>{
      "description": description,
      "hashtags": hashtags,
      "size": size,
    };

    if (photoFile != null) {
      formMap["photo"] = await MultipartFile.fromFile(photoFile.path);
    }

    final formData = FormData.fromMap(formMap);

    final response = await _http.post(
      AppApi.postGenerate,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return GeneratedPostModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> saveGeneratedPost({
    required String generatedDescription,
    required String originalDescription,
    required String hashtags,
    required String? tempPhotoPath,
    required String size,
  }) async {
    final payload = {
      "generatedDescription": generatedDescription,
      "originalDescription": originalDescription,
      "hashtags": hashtags,
      "tempPhotoPath": tempPhotoPath,
      "size": size,
    };
    await _http.post(AppApi.postSave, data: payload);
  }
}


