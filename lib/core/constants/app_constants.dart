import 'package:flutter/material.dart';
import 'package:instai/core/constants/app_colors.dart';

class AppConstants {
  static const tokenKey = "_token";
  static const themeIsDarkKey = "_theme_is_dark";

  static const gradient = LinearGradient(
    colors: AppColors.gradientColors,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const kLeadingWidth = 200.0;
}
