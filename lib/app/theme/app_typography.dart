import 'package:flutter/material.dart';

abstract final class AppTypography {
  static const fontFamily = 'Inter';

  /// Cifras de ancho fijo: los montos no "bailan" al animarse ni al alinearse.
  static const tabular = [FontFeature.tabularFigures()];

  static TextTheme textTheme(Color primary, Color secondary) {
    TextStyle s(double size, FontWeight w, {double? height, double ls = 0, Color? c}) => TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: w,
      height: height,
      letterSpacing: ls,
      color: c ?? primary,
    );

    return TextTheme(
      displayLarge: s(48, FontWeight.w700, height: 1.05, ls: -1.5),
      displayMedium: s(40, FontWeight.w700, height: 1.1, ls: -1.2),
      displaySmall: s(34, FontWeight.w700, height: 1.1, ls: -1),
      headlineLarge: s(30, FontWeight.w700, height: 1.15, ls: -0.8),
      headlineMedium: s(26, FontWeight.w700, height: 1.2, ls: -0.6),
      headlineSmall: s(22, FontWeight.w600, height: 1.25, ls: -0.4),
      titleLarge: s(20, FontWeight.w600, height: 1.3, ls: -0.3),
      titleMedium: s(16, FontWeight.w600, height: 1.35, ls: -0.1),
      titleSmall: s(14, FontWeight.w600, height: 1.35),
      bodyLarge: s(16, FontWeight.w400, height: 1.45),
      bodyMedium: s(14, FontWeight.w400, height: 1.45),
      bodySmall: s(12, FontWeight.w400, height: 1.4, c: secondary),
      labelLarge: s(15, FontWeight.w600, height: 1.2),
      labelMedium: s(13, FontWeight.w500, height: 1.2, c: secondary),
      labelSmall: s(11, FontWeight.w500, height: 1.2, ls: 0.2, c: secondary),
    );
  }

  /// Estilo para montos grandes (balance, saldo de tarjeta…).
  static TextStyle amount(double size, {Color? color, FontWeight weight = FontWeight.w700}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: size,
    fontWeight: weight,
    height: 1.05,
    letterSpacing: -size * 0.035,
    fontFeatures: tabular,
    color: color,
  );
}
