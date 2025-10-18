import 'package:flutter/material.dart';
import 'app_colors.dart';

/// 🎭 Configuración global del tema
class AppTheme {
  static ThemeData get light => ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
