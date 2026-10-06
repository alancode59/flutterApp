import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:finanzas/app/shell/app_nav_bar.dart';
import 'package:finanzas/app/theme/app_palette.dart';
import 'package:finanzas/core/database/app_database.dart';
import 'package:finanzas/features/settings/data/drift_settings_repository.dart';
import 'package:finanzas/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Flujo completo contra la base de datos real del dispositivo.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Finder navItem(String label) =>
      find.descendant(of: find.byType(AppNavBar), matching: find.bySemanticsLabel(label));

  Future<void> settle(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
  }

  testWidgets('bienvenida, navegación y ajustes persistentes', (tester) async {
    await app.main();
    await settle(tester);

    // En una instalación limpia aparece la bienvenida; si ya se vio, se abre Inicio.
    if (find.text('Omitir').evaluate().isNotEmpty) {
      await tester.tap(find.text('Omitir'));
      await settle(tester);
    }
    expect(find.text('Disponible esta quincena'), findsOneWidget);

    for (final (tab, text) in [
      ('Movimientos', 'Tu historial está vacío'),
      ('Tarjetas', 'Agrega tu primera tarjeta'),
      ('Análisis', 'Sin datos para analizar'),
      ('Inicio', 'Disponible esta quincena'),
    ]) {
      await tester.tap(navItem(tab));
      await tester.pumpAndSettle();
      expect(find.text(text), findsOneWidget, reason: tab);
    }

    await tester.tap(find.byTooltip('Más opciones'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ajustes'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Oscuro'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Coral'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Coral'));
    await tester.pumpAndSettle();

    final ctx = tester.element(find.text('Paleta de color'));
    expect(Theme.of(ctx).brightness, Brightness.dark);
    expect(Theme.of(ctx).colorScheme.primary, AppPalette.coral.dark.accent);

    // Lo guardado se lee desde una conexión nueva a la misma base (a propósito).
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    final db = AppDatabase.defaults();
    final saved = await DriftSettingsRepository(db).load();
    await db.close();
    expect(saved.onboardingCompleted, isTrue);
    expect(saved.themeMode, ThemeMode.dark);
    expect(saved.palette, AppPaletteId.coral);

    // Deja la app como estaba para el usuario.
    await tester.tap(find.text('Grafito'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Sistema'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sistema'));
    await tester.pumpAndSettle();
  });
}
