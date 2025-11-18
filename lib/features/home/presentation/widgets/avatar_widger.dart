import 'package:flutter/material.dart';
import 'package:instai/core/constants/app_assets.dart';
import 'package:instai/features/home/domain/entity/user_enttiy.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key, required this.userInfo});

  final UserEnttiy userInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Skeleton.replace(
          replacement: const Skeleton.shade(
            child: ClipRRect(child: CircleAvatar(radius: 30.0)),
          ),
          child: CachedNetworkImage(
            imageUrl: userInfo.avatarPath ?? "",
            errorWidget: (context, url, error) => ClipOval(
              clipBehavior: Clip.hardEdge,
              child: SizedBox.square(
                dimension: 60,
                child: Image.asset(
                  AppAssets.imgaes.avatarBg,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            imageBuilder: (context, imageProvider) =>
                CircleAvatar(radius: 30.0, child: Image(image: imageProvider)),
          ),
        ),
        const SizedBox(width: 5.0),
        Skeleton.leaf(
          child: Text(
            userInfo.username,
            style: TextTheme.of(context).headlineMedium,
          ),
        ),
      ],
    );
  }
}
