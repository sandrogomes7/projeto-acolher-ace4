import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tokens de cor extraídos diretamente do Figma "Acolhimento Digital".
class AppColors {
  static const background = Color(0xFFFCF8F5); // off-white quente
  static const surfaceSoft = Color(0xFFE6F4EF); // verde clarinho (ilustração / botão ouvir)
  static const primary = Color(0xFF137A63); // verde dos botões
  static const brandDark = Color(0xFF0C5446); // verde da marca "Acolher"
  static const textDark = Color(0xFF1E2A28);
  static const textMuted = Color(0xFF5C6B66);
  static const white = Color(0xFFFFFFFF);

  // Bege das bordas, divisórias e barras inativas (NÃO é o verde claro!)
  static const border = Color(0xFFEFE7E1);

  // Card de acolhimento (rosa suave) — usado nas telas de etapa
  static const pinkSoft = Color(0xFFFBE7EF);
  static const pinkText = Color(0xFF9B2F5E);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        background: AppColors.background,
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
