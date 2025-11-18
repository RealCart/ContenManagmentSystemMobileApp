import 'package:flutter/material.dart';

class ThemeModeUtils {
  static bool isLightThemeMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light;
}
