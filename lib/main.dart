import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'app/app.dart';
import 'core/database/app_database.dart';
import 'features/recurring/data/recurring_repository.dart';
import 'features/settings/data/drift_settings_repository.dart';
import 'features/settings/domain/app_settings.dart';
import 'features/settings/presentation/settings_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'es_MX';
  await initializeDateFormatting('es_MX');
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  final db = AppDatabase.defaults();
  AppSettings settings;
  try {
    settings = await DriftSettingsRepository(db).load();
  } catch (e, st) {
    // Si la base no se puede leer, la app abre con valores por defecto.
    debugPrint('No se pudieron leer los ajustes: $e\n$st');
    settings = const AppSettings();
  }

  try {
    // Registra quincenas, rentas, etc. que vencieron mientras la app estuvo cerrada.
    await RecurringRepository(db).generateDue(DateTime.now());
  } catch (e, st) {
    debugPrint('No se pudieron generar los recurrentes: $e\n$st');
  }

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        initialSettingsProvider.overrideWithValue(settings),
      ],
      child: const FinanzasApp(),
    ),
  );
}
