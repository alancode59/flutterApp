import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app/theme/app_palette.dart';

part 'app_settings.freezed.dart';

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(AppPaletteId.medianoche) AppPaletteId palette,
    @Default(false) bool onboardingCompleted,
  }) = _AppSettings;
}
