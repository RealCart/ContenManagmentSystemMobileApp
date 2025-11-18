import 'package:flutter/material.dart';

class ThemeModeInheritatedWidget extends InheritedWidget {
  const ThemeModeInheritatedWidget({
    super.key,
    required this.appThemeMode,
    required super.child,
  });

  final ValueNotifier<ThemeMode> appThemeMode;

  static ThemeModeInheritatedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ThemeModeInheritatedWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
