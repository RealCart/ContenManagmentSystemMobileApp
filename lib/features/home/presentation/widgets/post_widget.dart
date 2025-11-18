import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instai/core/constants/app_assets.dart';
import 'package:instai/core/constants/app_colors.dart';
import 'package:instai/core/utils/date_time_ex.dart';
import 'package:instai/core/utils/theme_mode_utils.dart';
import 'package:instai/features/home/domain/entity/post_entity.dart';
import 'package:instai/features/home/presentation/widgets/post_overflow_menu_button.dart';
import 'package:instai/features/home/presentation/bloc/home_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post, required this.onPhotoTap});

  final PostEntity post;
  final void Function({required String photoUrl, required String tag})
  onPhotoTap;

  @override
  Widget build(BuildContext context) {
    final String tag = "${post.id}#${post.createdAt}";

    return Container(
      decoration: BoxDecoration(
        color: ThemeModeUtils.isLightThemeMode(context)
            ? AppColors.white
            : const Color(0xFF181818),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColoredBox(
            color: AppColors.gray.withAlpha(50),
            child: AspectRatio(
              aspectRatio: 6 / 4,
              child: Skeleton.replace(
                replacement: const Skeleton.shade(
                  child: ColoredBox(
                    color: Colors.black,
                    child: SizedBox.square(dimension: double.infinity),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          onPhotoTap(photoUrl: post.photosPath[0], tag: tag),
                      child: Positioned.fill(
                        child: Hero(
                          tag: tag,
                          child: CachedNetworkImage(
                            imageUrl: post.photosPath[0],
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: PostOverflowMenuButton(
                        onTapDelete: () {
                          BlocProvider.of<HomeBloc>(
                            context,
                          ).add(DeletePostEvent(post.id));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Skeleton.ignore(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                onPressed: () async {
                  final String shareText = [
                    if (post.photosPath.isNotEmpty) post.photosPath.first,
                    post.description,
                    if (post.hashtags.isNotEmpty) post.hashtags,
                  ].join("\n\n");
                  final box = context.findRenderObject() as RenderBox?;
                  await SharePlus.instance.share(
                    ShareParams(
                      text: shareText,
                      subject: 'Share post',
                      sharePositionOrigin: box == null
                          ? null
                          : box.localToGlobal(Offset.zero) & box.size,
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  AppAssets.icon.share,
                  width: 25.0,
                  height: 25.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 6.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post.hashtags.isNotEmpty) ...[
                  Skeleton.leaf(
                    child: Text(
                      post.hashtags,
                      style: const TextStyle(
                        color: AppColors.gray,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                ],
                Skeleton.leaf(
                  child: _ExpandableDescription(
                    text: post.description,
                    style: TextTheme.of(context).bodyMedium,
                    trimLines: 3,
                  ),
                ),
                const SizedBox(height: 6.0),
                Skeleton.ignore(
                  child: Text(
                    post.createdAt.formatToText(),
                    style: TextTheme.of(context).bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandableDescription extends StatefulWidget {
  const _ExpandableDescription({
    required this.text,
    this.style,
    this.trimLines = 3,
  });

  final String text;
  final TextStyle? style;
  final int trimLines;

  @override
  State<_ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<_ExpandableDescription>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isOverflowing = false;
  double _lastMaxWidth = 0.0;

  void _measureOverflow(BoxConstraints constraints) {
    final maxWidth = constraints.maxWidth;
    if (maxWidth == _lastMaxWidth) return;
    _lastMaxWidth = maxWidth;

    final TextPainter painter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      maxLines: widget.trimLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    final overflowing = painter.didExceedMaxLines;
    if (overflowing != _isOverflowing) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() => _isOverflowing = overflowing);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _measureOverflow(constraints);
        return Stack(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: Text(
                widget.text,
                style: widget.style,
                maxLines: _isExpanded ? null : widget.trimLines,
                overflow: _isExpanded
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
              ),
            ),
            if (_isOverflowing && !_isExpanded)
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () => setState(() => _isExpanded = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      '...',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
