import 'package:flutter/material.dart';
import 'package:instai/core/constants/app_colors.dart';
import 'package:instai/core/utils/theme_mode_utils.dart';

class PostOverflowMenuButton extends StatefulWidget {
  const PostOverflowMenuButton({super.key, required this.onTapDelete});

  final VoidCallback onTapDelete;

  @override
  State<PostOverflowMenuButton> createState() => _PostOverflowMenuButtonState();
}

class _PostOverflowMenuButtonState extends State<PostOverflowMenuButton> {
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;
  bool _isMenuOpen = false;

  @override
  void dispose() {
    _removeMenu();
    super.dispose();
  }

  void _toggleMenu() {
    if (_isMenuOpen) {
      _removeMenu();
    } else {
      _showMenu();
    }
  }

  void _showMenu() {
    final overlay = Overlay.of(context);
    final bool isLight = ThemeModeUtils.isLightThemeMode(context);
    final Color backgroundColor = isLight
        ? Colors.white
        : const Color(0xFF1F1F1F);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(-90, 30),
              child: TapRegion(
                onTapOutside: (event) => _removeMenu(),
                child: TextButton.icon(
                  onPressed: () {
                    widget.onTapDelete.call();
                    _removeMenu();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: backgroundColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: AppColors.red,
                  ),
                  label: const Text(
                    "Delete",
                    style: TextStyle(color: AppColors.red),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
    setState(() {
      _isMenuOpen = true;
    });
  }

  void _removeMenu() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      if (mounted) {
        setState(() {
          _isMenuOpen = false;
        });
      } else {
        _isMenuOpen = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: IconButton(
        onPressed: _toggleMenu,
        splashRadius: 18.0,
        icon: const Icon(Icons.more_vert, size: 20, color: AppColors.white),
      ),
    );
  }
}
