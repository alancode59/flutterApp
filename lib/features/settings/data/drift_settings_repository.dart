import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app/theme/app_palette.dart';
import '../../../core/database/app_database.dart';
import '../domain/app_settings.dart';
import '../domain/settings_repository.dart';

part 'drift_settings_repository.g.dart';

class DriftSettingsRepository implements SettingsRepository {
  DriftSettingsRepository(this._db);

  final AppDatabase _db;

  static const _themeMode = 'theme_mode';
  static const _palette = 'palette';
  static const _onboarding = 'onboarding_completed';

  @override
  Future<AppSettings> load() async {
    final rows = await _db.select(_db.settingsEntries).get();
    final map = {for (final r in rows) r.key: r.value};
    const defaults = AppSettings();

    return AppSettings(
      themeMode: ThemeMode.values.firstWhereOrNull((m) => m.name == map[_themeMode]) ?? defaults.themeMode,
      palette: AppPaletteId.values.firstWhereOrNull((p) => p.name == map[_palette]) ?? defaults.palette,
      onboardingCompleted: map[_onboarding] == 'true',
    );
  }

  @override
  Future<void> save(AppSettings settings) {
    final values = {
      _themeMode: settings.themeMode.name,
      _palette: settings.palette.name,
      _onboarding: settings.onboardingCompleted.toString(),
    };
    return _db.batch((b) {
      b.insertAllOnConflictUpdate(_db.settingsEntries, [
        for (final e in values.entries) SettingsEntriesCompanion.insert(key: e.key, value: e.value),
      ]);
    });
  }
}

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) => DriftSettingsRepository(ref.watch(appDatabaseProvider));
