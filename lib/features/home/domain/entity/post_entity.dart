import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  const PostEntity({
    required this.id,
    required this.description,
    required this.hashtags,
    required this.photosPath,
    required this.createdAt,
  });

  final int id;
  final String description;
  final String hashtags;
  final List<String> photosPath;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, description, hashtags, photosPath, createdAt];
}
