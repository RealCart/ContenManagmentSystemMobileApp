import 'dart:io';

class GeneratePostParamsEntity {
  const GeneratePostParamsEntity({
    this.photoFile,
    required this.description,
    required this.hashtags,
    required this.size,
  });

  final File? photoFile;
  final String description;
  final List<String> hashtags;
  final String size;
}


