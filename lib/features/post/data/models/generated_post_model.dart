import 'package:instai/core/constants/app_api.dart';
import 'package:instai/features/post/domain/entities/generated_post_entity.dart';

class GeneratedPostModel {
  const GeneratedPostModel({
    required this.generatedDescription,
    required this.originalDescription,
    required this.hashtags,
    required this.tempPhotoPath,
    required this.size,
    required this.generatedAt,
  });

  final String generatedDescription;
  final String originalDescription;
  final String hashtags;
  final String? tempPhotoPath;
  final String size;
  final DateTime generatedAt;

  GeneratedPostEntity toEntity() {
    return GeneratedPostEntity(
      generatedDescription: generatedDescription,
      originalDescription: originalDescription,
      hashtags: hashtags,
      tempPhotoUrl: tempPhotoPath == null
          ? null
          : "${AppApi.baseBaseUrl}/${tempPhotoPath!}",
      tempPhotoPath: tempPhotoPath,
      size: size,
      generatedAt: generatedAt,
    );
  }

  factory GeneratedPostModel.fromJson(Map<String, dynamic> json) {
    return GeneratedPostModel(
      generatedDescription: json["generatedDescription"] as String,
      originalDescription: json["originalDescription"] as String,
      hashtags: json["hashtags"] as String,
      tempPhotoPath: json["tempPhotoPath"] as String?,
      size: json["size"] as String,
      generatedAt: DateTime.parse(json["generatedAt"] as String),
    );
  }
}


