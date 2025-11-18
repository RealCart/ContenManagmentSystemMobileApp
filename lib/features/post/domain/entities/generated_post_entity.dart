import 'package:equatable/equatable.dart';

class GeneratedPostEntity extends Equatable {
  const GeneratedPostEntity({
    required this.generatedDescription,
    required this.originalDescription,
    required this.hashtags,
    required this.tempPhotoUrl,
    required this.tempPhotoPath,
    required this.size,
    required this.generatedAt,
  });

  final String generatedDescription;
  final String originalDescription;
  final String hashtags;
  final String? tempPhotoUrl;
  final String? tempPhotoPath;
  final String size;
  final DateTime generatedAt;

  @override
  List<Object?> get props => [
        generatedDescription,
        originalDescription,
        hashtags,
        tempPhotoUrl,
        tempPhotoPath,
        size,
        generatedAt,
      ];
}


