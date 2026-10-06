import 'package:flutter/material.dart';

/// Paletas disponibles. El nombre del enum se guarda en Ajustes, así que no
/// se deben renombrar sin una migración.
enum AppPaletteId { grafito, menta, coral }

/// Colores base de una paleta para un brillo (claro u oscuro).
@immutable
class PaletteColors {
  const PaletteColors({
    required this.background,
    required this.surface,
    required this.surfaceHigh,
    required this.outline,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.onAccent,
    required this.income,
    required this.expense,
    required this.warning,
  });

  /// Fondo de la pantalla.
  final Color background;

  /// Tarjetas y contenedores principales.
  final Color surface;

  /// Contenedores sobre `surface` (campos, chips, barras de progreso).
  final Color surfaceHigh;

  final Color outline;
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;
  final Color onAccent;

  /// Montos positivos (ingresos, abonos que me hacen).
  final Color income;

  /// Montos negativos (gastos, excedentes de presupuesto).
  final Color expense;

  final Color warning;
}

@immutable
class AppPalette {
  const AppPalette({
    required this.id,
    required this.name,
    required this.description,
    required this.light,
    required this.dark,
  });

  final AppPaletteId id;
  final String name;
  final String description;
  final PaletteColors light;
  final PaletteColors dark;

  PaletteColors of(Brightness brightness) => brightness == Brightness.dark ? dark : light;

  static AppPalette byId(AppPaletteId id) => all.firstWhere((p) => p.id == id, orElse: () => grafito);

  static const List<AppPalette> all = [grafito, menta, coral];

  static const grafito = AppPalette(
    id: AppPaletteId.grafito,
    name: 'Grafito',
    description: 'Neutra con acento índigo. Sobria y con mucho contraste.',
    light: PaletteColors(
      background: Color(0xFFF4F4F6),
      surface: Color(0xFFFFFFFF),
      surfaceHigh: Color(0xFFECECF1),
      outline: Color(0xFFDDDDE4),
      textPrimary: Color(0xFF0B0B0F),
      textSecondary: Color(0xFF5E5E6D),
      accent: Color(0xFF4B4BE8),
      onAccent: Color(0xFFFFFFFF),
      income: Color(0xFF13905D),
      expense: Color(0xFFD13A37),
      warning: Color(0xFFB4761C),
    ),
    dark: PaletteColors(
      background: Color(0xFF0B0B0F),
      surface: Color(0xFF16161D),
      surfaceHigh: Color(0xFF212129),
      outline: Color(0xFF2C2C36),
      textPrimary: Color(0xFFF5F5F7),
      textSecondary: Color(0xFF9B9BA9),
      accent: Color(0xFF6464F7),
      onAccent: Color(0xFFFFFFFF),
      income: Color(0xFF34C98E),
      expense: Color(0xFFFF6461),
      warning: Color(0xFFF5B43C),
    ),
  );

  static const menta = AppPalette(
    id: AppPaletteId.menta,
    name: 'Menta',
    description: 'Verde menta sobre tinta. Usa azul para los ingresos.',
    light: PaletteColors(
      background: Color(0xFFF2F6F5),
      surface: Color(0xFFFFFFFF),
      surfaceHigh: Color(0xFFE7EEEC),
      outline: Color(0xFFD5DFDC),
      textPrimary: Color(0xFF0E1312),
      textSecondary: Color(0xFF53625E),
      accent: Color(0xFF0E9F6E),
      onAccent: Color(0xFF04140D),
      income: Color(0xFF2563EB),
      expense: Color(0xFFD13A37),
      warning: Color(0xFFB4761C),
    ),
    dark: PaletteColors(
      background: Color(0xFF0E1312),
      surface: Color(0xFF171E1C),
      surfaceHigh: Color(0xFF212A28),
      outline: Color(0xFF2C3734),
      textPrimary: Color(0xFFF2F5F4),
      textSecondary: Color(0xFF93A39E),
      accent: Color(0xFF1FC48A),
      onAccent: Color(0xFF04140D),
      income: Color(0xFF5B9BFF),
      expense: Color(0xFFFF6461),
      warning: Color(0xFFF5B43C),
    ),
  );

  static const coral = AppPalette(
    id: AppPaletteId.coral,
    name: 'Coral',
    description: 'Cálida y cercana, con acento coral sobre pizarra.',
    light: PaletteColors(
      background: Color(0xFFF5F5F7),
      surface: Color(0xFFFFFFFF),
      surfaceHigh: Color(0xFFEDEEF2),
      outline: Color(0xFFDDDFE5),
      textPrimary: Color(0xFF111318),
      textSecondary: Color(0xFF5D6170),
      accent: Color(0xFFE5532F),
      onAccent: Color(0xFF1A0905),
      income: Color(0xFF13905D),
      expense: Color(0xFFC81E5A),
      warning: Color(0xFFB4761C),
    ),
    dark: PaletteColors(
      background: Color(0xFF111318),
      surface: Color(0xFF1A1D24),
      surfaceHigh: Color(0xFF242832),
      outline: Color(0xFF313541),
      textPrimary: Color(0xFFF4F5F7),
      textSecondary: Color(0xFF9A9FAD),
      accent: Color(0xFFFF6B4A),
      onAccent: Color(0xFF1A0905),
      income: Color(0xFF34C98E),
      expense: Color(0xFFFF5C8A),
      warning: Color(0xFFF5B43C),
    ),
  );
}
