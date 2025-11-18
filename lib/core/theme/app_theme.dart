import 'package:flutter/material.dart';
import 'package:instai/core/constants/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android:
            PredictiveBackFullscreenPageTransitionsBuilder(),
      },
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.black,
      refreshBackgroundColor: AppColors.white,
    ),
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.black,
      radius: BorderRadius.all(Radius.circular(10.0)),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.blue,
      selectionColor: AppColors.blue,
      selectionHandleColor: AppColors.blue,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      brightness: Brightness.light,
    ),
    cardColor: AppColors.white,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      bodySmall: TextStyle(fontSize: 11.0, color: AppColors.black),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(iconSize: 30.0),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF3F3F3),
      hintStyle: TextStyle(color: AppColors.gray),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
      enabledBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderSide: BorderSide(color: AppColors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      focusedBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderSide: BorderSide(color: AppColors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      errorBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) =>
              states.contains(WidgetState.selected) ? AppColors.accentBlue : const Color(0xFFF3F3F3),
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) =>
              states.contains(WidgetState.selected) ? AppColors.white : AppColors.black,
        ),
        side: WidgetStateProperty.resolveWith<BorderSide?>(
          (states) => states.contains(WidgetState.selected)
              ? const BorderSide(color: Colors.transparent)
              : const BorderSide(color: Colors.black12),
        ),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor:  const WidgetStatePropertyAll<Color>(AppColors.blue),
        foregroundColor: const WidgetStatePropertyAll<Color>(AppColors.white),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll<Color>(AppColors.black),
        side: const WidgetStatePropertyAll<BorderSide>(
          BorderSide(color: Colors.black12),
        ),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android:
            PredictiveBackFullscreenPageTransitionsBuilder(),
      },
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.white,
      refreshBackgroundColor: AppColors.black,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 27, 27, 27),
    cardColor: const Color(0xFF181818),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: TextStyle(fontSize: 11.0, color: Colors.white54),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      surfaceTintColor: Color.fromARGB(255, 27, 27, 27),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.white,
      radius: BorderRadius.all(Radius.circular(10.0)),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.blue,
      selectionColor: AppColors.blue,
      selectionHandleColor: AppColors.blue,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(iconSize: 30.0),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF181818),
      hintStyle: TextStyle(color: Colors.white54),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
      enabledBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderSide: BorderSide(color: AppColors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      focusedBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderSide: BorderSide(color: AppColors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      errorBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) =>
              states.contains(WidgetState.selected) ? AppColors.accentBlue : const Color(0xFF1F1F1F),
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => AppColors.white,
        ),
        side: WidgetStateProperty.resolveWith<BorderSide?>(
          (states) => states.contains(WidgetState.selected)
              ? const BorderSide(color: Colors.transparent)
              : const BorderSide(color: Colors.white24),
        ),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll<Color>(AppColors.blue),
        foregroundColor: const WidgetStatePropertyAll<Color>(AppColors.white),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll<Color>(AppColors.white),
        side: const WidgetStatePropertyAll<BorderSide>(
          BorderSide(color: Colors.white24),
        ),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    ),
    extensions: [
      const SkeletonizerConfigData.dark(
        containersColor: Color.fromARGB(255, 27, 27, 27),
      ),
    ],
  );
}
