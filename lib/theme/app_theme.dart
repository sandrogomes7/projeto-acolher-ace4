import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xFFFCF8F5);
  static const surfaceSoft = Color(0xFFE6F4EF);
  static const primary = Color(0xFF137A63);
  static const brandDark = Color(0xFF0C5446);
  static const textDark = Color(0xFF1E2A28);
  static const textMuted = Color(0xFF5C6B66);
  static const white = Color(0xFFFFFFFF);

  // Bege das bordas, divisórias e barras inativas
  static const border = Color(0xFFEFE7E1);

  // Card de acolhimento (rosa suave) — usado nas telas de etapa
  static const pinkSoft = Color(0xFFFBE7EF);
  static const pinkText = Color(0xFF9B2F5E);

  static const bgCream = Color(0xFFFFF8F1);
  static const surfaceWarm = Color(0xFFFFFDFA);
  static const surfaceLavender = Color(0xFFF1E7F1);
  static const borderLight = Color(0xFFEADFD6);
  static const textBody = Color(0xFF3F3038);
  static const textTertiary = Color(0xFF71635F);
  static const textMutedWarm = Color(0xFFA8959B);
  static const primaryPlum = Color(0xFF7C4A67);
  static const shadowLight = Color(0x176B4452);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.background,
        brightness: Brightness.light,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textDark,
        displayColor: AppColors.textDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}
