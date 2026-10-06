import 'package:drift/native.dart';
import 'package:finanzas/app/theme/app_palette.dart';
import 'package:finanzas/core/database/app_database.dart';
import 'package:finanzas/features/settings/data/drift_settings_repository.dart';
import 'package:finanzas/features/settings/domain/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftSettingsRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = DriftSettingsRepository(db);
  });

  tearDown(() => db.close());

  test('sin datos regresa los valores por defecto', () async {
    expect(await repo.load(), const AppSettings());
  });

  test('guarda y vuelve a leer los ajustes', () async {
    const settings = AppSettings(
      themeMode: ThemeMode.dark,
      palette: AppPaletteId.coral,
      onboardingCompleted: true,
    );
    await repo.save(settings);
    expect(await repo.load(), settings);
  });

  test('sobrescribe valores anteriores', () async {
    await repo.save(const AppSettings(themeMode: ThemeMode.dark));
    await repo.save(const AppSettings(themeMode: ThemeMode.light));
    expect((await repo.load()).themeMode, ThemeMode.light);
  });

  test('un valor desconocido cae al valor por defecto', () async {
    await db
        .into(db.settingsEntries)
        .insert(SettingsEntriesCompanion.insert(key: 'palette', value: 'inexistente'));
    expect((await repo.load()).palette, AppPaletteId.medianoche);
  });
}
