import 'package:flutter/material.dart';
import 'package:instai/core/constants/app_colors.dart';

extension GlobalLoaderContextEx on BuildContext {
  void showLoader() => GlobalLoader.instance.show(this);
  void hideLoader() => GlobalLoader.instance.hide(this);
}

class GlobalLoader {
  GlobalLoader._();
  static final GlobalLoader instance = GlobalLoader._();

  bool _isShowing = false;

  void show(BuildContext context) {
    if (_isShowing) return;
    _isShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) {
        return Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 20.0,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: AppColors.gray,
            ),
            child: const CircularProgressIndicator.adaptive(
              backgroundColor: Colors.white,
            ),
          ),
        );
      },
    );
  }

  void hide(BuildContext context) {
    if (!_isShowing) return;

    final nav = Navigator.of(context, rootNavigator: true);
    if (nav.canPop()) {
      nav.pop();
    }

    _isShowing = false;
  }
}
