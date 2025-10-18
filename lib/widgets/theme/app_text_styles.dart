import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// 🧩 Tipografías globales basadas en Google Fonts (Poppins)
class AppTextStyles {
  // Encabezado grande, usado en pantallas como Welcome o Login
  static TextStyle get heading => GoogleFonts.poppins(
    color: AppColors.white,
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  // Título principal en secciones o tarjetas
  static TextStyle get title => GoogleFonts.poppins(
    color: AppColors.textDark,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // Subtítulos o textos secundarios
  static TextStyle get subtitle =>
      GoogleFonts.poppins(color: AppColors.textLight, fontSize: 14);

  // Textos pequeños o aclaratorios
  static TextStyle get small =>
      GoogleFonts.poppins(color: AppColors.textLight, fontSize: 12);

  // 👇 Agregado correctamente para reemplazar los null
  static TextStyle get titleLarge => GoogleFonts.poppins(
    color: AppColors.textDark,
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get bodySmall =>
      GoogleFonts.poppins(color: AppColors.textLight, fontSize: 13);
}
