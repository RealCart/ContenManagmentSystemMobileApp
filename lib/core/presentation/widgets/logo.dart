import 'package:flutter/material.dart';
import 'package:instai/core/constants/app_colors.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "InstAI",
      style: TextStyle(
        color: AppColors.white,
        fontSize: 48.0,
        fontFamily: "MomoSignature",
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
