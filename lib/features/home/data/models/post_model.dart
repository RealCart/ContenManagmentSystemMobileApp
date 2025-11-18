import 'package:instai/core/constants/app_api.dart';
import 'package:instai/features/home/domain/entity/post_entity.dart';

class PostModel {
  const PostModel({
    required this.id,
    required this.generatedDescription,
    required this.hashtags,
    required this.photoPath,
    required this.createdAt,
  });

  final int id;
  final String generatedDescription;
  final String hashtags;
  final List<String> photoPath;
  final DateTime createdAt;

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      description: generatedDescription,
      hashtags: hashtags,
      photosPath: photoPath,
      createdAt: createdAt,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["id"] as int,
      generatedDescription: json["generatedDescription"] as String,
      hashtags: json['hashtags'] as String,
      photoPath: ["${AppApi.baseBaseUrl}/${(json["photoPath"] as String)}"],
      createdAt: DateTime.parse(json["createdAt"] as String),
    );
  }
}
