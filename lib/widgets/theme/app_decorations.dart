import 'package:flutter/material.dart';
import 'app_colors.dart';

/// 🌈 Decoraciones y gradientes reutilizables
class AppDecorations {
  static const LinearGradient mainGradient = LinearGradient(
    colors: [AppColors.primary, AppColors.secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxDecoration get whiteCard => BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ],
  );
}
