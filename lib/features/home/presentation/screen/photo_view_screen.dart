import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instai/core/constants/app_colors.dart';
import 'package:photo_view/photo_view.dart';

@RoutePage()
class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({
    super.key,
    required this.photoPath,
    required this.tag,
  });

  final String photoPath;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.transparent),
      body: SafeArea(
        child: Center(
          child: PhotoView(
            imageProvider: CachedNetworkImageProvider(photoPath),
            backgroundDecoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            heroAttributes: PhotoViewHeroAttributes(tag: tag),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    );
  }
}
