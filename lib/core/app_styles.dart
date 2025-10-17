import 'package:alertas_tempranas/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 💎 Estilos globales centralizados para Alertas Tempranas
class AppStyles {
  /// 🌈 Gradiente de fondo principal
  static const LinearGradient mainGradient = LinearGradient(
    colors: [AppColors.primary, AppColors.secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// 🧱 Tarjetas blancas con sombra suave
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

  /// 🔤 Títulos y texto
  static TextStyle get heading => GoogleFonts.poppins(
    color: AppColors.white,
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get title => GoogleFonts.poppins(
    color: AppColors.textDark,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get subtitle =>
      GoogleFonts.poppins(color: AppColors.textLight, fontSize: 14);

  static TextStyle get small =>
      GoogleFonts.poppins(color: AppColors.textLight, fontSize: 12);

  /// 🔘 Botones
  static ButtonStyle get primaryButton => ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
  );

  static ButtonStyle get outlineButton => OutlinedButton.styleFrom(
    side: const BorderSide(color: AppColors.secondary, width: 1.4),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    textStyle: GoogleFonts.poppins(fontSize: 15),
  );
}
