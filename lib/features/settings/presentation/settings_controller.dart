import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app/theme/app_palette.dart';
import '../data/drift_settings_repository.dart';
import '../domain/app_settings.dart';

part 'settings_controller.g.dart';

/// Ajustes leídos antes del primer frame, para no parpadear de tema al abrir.
@Riverpod(keepAlive: true)
AppSettings initialSettings(Ref ref) =>
    throw UnimplementedError('initialSettingsProvider se sobrescribe en main()');

@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  @override
  AppSettings build() => ref.watch(initialSettingsProvider);

  Future<void> setThemeMode(ThemeMode mode) => _update(state.copyWith(themeMode: mode));

  Future<void> setPalette(AppPaletteId palette) => _update(state.copyWith(palette: palette));

  Future<void> setOnboardingCompleted(bool value) => _update(state.copyWith(onboardingCompleted: value));

  /// Actualiza la UI de inmediato y revierte si no se pudo guardar.
  Future<void> _update(AppSettings next) async {
    final previous = state;
    state = next;
    try {
      await ref.read(settingsRepositoryProvider).save(next);
    } catch (e, st) {
      debugPrint('No se pudieron guardar los ajustes: $e\n$st');
      state = previous;
      rethrow;
    }
  }
}
