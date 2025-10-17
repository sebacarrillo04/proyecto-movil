import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// 🔘 Estilos globales para botones
class AppButtons {
  static ButtonStyle get primary => ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondary,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
  );

  static ButtonStyle get outline => OutlinedButton.styleFrom(
    side: const BorderSide(color: AppColors.secondary, width: 1.4),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    textStyle: GoogleFonts.poppins(fontSize: 15),
  );
}
