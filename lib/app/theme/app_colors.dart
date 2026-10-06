import 'package:flutter/material.dart';

import 'app_palette.dart';

/// Colores semánticos que Material no cubre (ingresos, gastos, avisos…).
/// Se leen con `context.colors`.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.income,
    required this.expense,
    required this.warning,
    required this.textSecondary,
    required this.surfaceHigh,
  });

  factory AppColors.fromPalette(PaletteColors p) => AppColors(
    income: p.income,
    expense: p.expense,
    warning: p.warning,
    textSecondary: p.textSecondary,
    surfaceHigh: p.surfaceHigh,
  );

  final Color income;
  final Color expense;
  final Color warning;
  final Color textSecondary;
  final Color surfaceHigh;

  @override
  AppColors copyWith({
    Color? income,
    Color? expense,
    Color? warning,
    Color? textSecondary,
    Color? surfaceHigh,
  }) => AppColors(
    income: income ?? this.income,
    expense: expense ?? this.expense,
    warning: warning ?? this.warning,
    textSecondary: textSecondary ?? this.textSecondary,
    surfaceHigh: surfaceHigh ?? this.surfaceHigh,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      surfaceHigh: Color.lerp(surfaceHigh, other.surfaceHigh, t)!,
    );
  }
}

extension AppThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get scheme => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
