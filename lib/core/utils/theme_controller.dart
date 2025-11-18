import 'package:flutter/material.dart';

class ThemeController extends InheritedWidget {
  final ValueNotifier<ThemeMode> notifier;

  const ThemeController({
    super.key,
    required this.notifier,
    required super.child,
  });

  bool get isDarkMode => notifier.value == ThemeMode.dark;

  static ThemeController of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<ThemeController>();
    assert(result != null, 'No ThemeController found in context');
    return result!;
  }

  void toggleMode(ThemeMode mode) {
    notifier.value = mode;
  }

  @override
  bool updateShouldNotify(covariant ThemeController oldWidget) =>
      notifier != oldWidget.notifier;
}
