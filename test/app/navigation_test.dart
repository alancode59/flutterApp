import 'package:drift/drift.dart' show DatabaseConnection, driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:finanzas/app/app.dart';
import 'package:finanzas/app/shell/app_nav_bar.dart';
import 'package:finanzas/core/database/app_database.dart';
import 'package:finanzas/features/cards/data/card_repository.dart';
import 'package:finanzas/features/cards/domain/credit_card.dart';
import 'package:finanzas/features/dashboard/presentation/dashboard_screen.dart';
import 'package:finanzas/features/reports/presentation/reports_screen.dart';
import 'package:finanzas/features/settings/data/drift_settings_repository.dart';
import 'package:finanzas/features/settings/domain/app_settings.dart';
import 'package:finanzas/features/settings/domain/settings_repository.dart';
import 'package:finanzas/features/settings/presentation/settings_controller.dart';
import 'package:finanzas/features/transactions/data/movement_repository.dart';
import 'package:finanzas/features/transactions/domain/movement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Repositorio en memoria: los ajustes no necesitan la base para estas pruebas.
class _MemorySettingsRepository implements SettingsRepository {
  AppSettings saved = const AppSettings();

  @override
  Future<AppSettings> load() async => saved;

  @override
  Future<void> save(AppSettings settings) async => saved = settings;
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  setUpAll(() => initializeDateFormatting('es_MX'));

  late AppDatabase db;

  Future<_MemorySettingsRepository> pumpApp(WidgetTester tester, {required bool onboardingDone}) async {
    db = AppDatabase(DatabaseConnection(NativeDatabase.memory(), closeStreamsSynchronously: true));
    final repo = _MemorySettingsRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          settingsRepositoryProvider.overrideWithValue(repo),
          initialSettingsProvider.overrideWithValue(AppSettings(onboardingCompleted: onboardingDone)),
        ],
        child: const FinanzasApp(),
      ),
    );
    // Deja terminar el splash, la transición y los esqueletos de carga.
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    return repo;
  }

  Future<void> tearDownApp(WidgetTester tester) async {
    // Desmonta la app para cerrar los streams de Drift antes de cerrar la base.
    await tester.pumpWidget(const SizedBox());
    // Las operaciones de Drift corren en tiempo real, fuera del reloj falso de la prueba.
    await tester.runAsync(db.close);
    await tester.pump(const Duration(seconds: 1));
  }

  Finder navItem(String label) =>
      find.descendant(of: find.byType(AppNavBar), matching: find.bySemanticsLabel(label));

  testWidgets('primera vez muestra la bienvenida y al omitirla llega a Inicio', (tester) async {
    final repo = await pumpApp(tester, onboardingDone: false);
    expect(find.text('Tu dinero, claro y en un solo lugar'), findsOneWidget);

    await tester.tap(find.text('Omitir'));
    await tester.pumpAndSettle();
    expect(find.text('Disponible esta quincena'), findsOneWidget);
    expect(repo.saved.onboardingCompleted, isTrue);
    await tearDownApp(tester);
  });

  testWidgets('la barra inferior cambia de sección', (tester) async {
    await pumpApp(tester, onboardingDone: true);

    await tester.tap(navItem('Tarjetas'));
    await tester.pumpAndSettle();
    expect(find.text('Agrega tu primera tarjeta'), findsOneWidget);

    await tester.tap(navItem('Movimientos'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Sin movimientos en este periodo'), findsOneWidget);
    await tearDownApp(tester);
  });

  testWidgets('alta rápida: monto, categoría preseleccionada y guardar', (tester) async {
    await pumpApp(tester, onboardingDone: true);

    await tester.tap(navItem('Agregar movimiento'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Guardar gasto'), findsOneWidget);

    for (final key in ['2', '5', '0', 'Punto decimal', '5']) {
      await tester.tap(find.bySemanticsLabel(key).last);
      await tester.pump();
    }
    expect(find.text(r'$250.5'), findsOneWidget);

    await tester.tap(find.text('Guardar gasto'));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    final saved = (await tester.runAsync(() => MovementRepository(db).watchRecent().first))!;
    expect(saved.single.amountCents, 25050);
    expect(find.textContaining(r'Gasto de $250.50 guardado'), findsOneWidget);
    expect(find.text(r'-$250.50'), findsOneWidget);
    await tearDownApp(tester);
  });

  testWidgets('deslizar para borrar pide confirmación y permite deshacer', (tester) async {
    await pumpApp(tester, onboardingDone: true);
    final repo = MovementRepository(db);
    await tester.runAsync(() async {
      final cats = await db.select(db.categories).get();
      await repo.add(
        Movement(
          kind: MovementKind.expense,
          amountCents: 12300,
          categoryId: cats.first.id,
          date: DateTime.now(),
          note: 'Tacos',
          paymentMethod: PaymentMethod.cash,
        ),
      );
    });

    await tester.tap(navItem('Movimientos'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Tacos'), findsOneWidget);

    await tester.drag(find.text('Tacos'), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(find.text('¿Eliminar este movimiento?'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Eliminar'));
    await tester.pumpAndSettle();
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 100)));
    await tester.pumpAndSettle();
    expect(find.text('Tacos'), findsNothing);
    expect(find.text('Movimiento eliminado'), findsOneWidget);

    await tester.tap(find.text('Deshacer'));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 100)));
    await tester.pumpAndSettle();
    expect(find.text('Tacos'), findsOneWidget);
    await tearDownApp(tester);
  });

  double opacityOf(WidgetTester tester, Type screen) => tester
      .renderObject<RenderAnimatedOpacity>(
        find.ancestor(of: find.byType(screen), matching: find.byType(AnimatedOpacity)).first,
      )
      .opacity
      .value;

  testWidgets('al regresar a una pestaña anterior, la saliente se oculta', (tester) async {
    await pumpApp(tester, onboardingDone: true);

    await tester.tap(navItem('Análisis'));
    await tester.pumpAndSettle();
    expect(opacityOf(tester, ReportsScreen), 1);

    await tester.tap(navItem('Inicio'));
    await tester.pumpAndSettle();
    expect(opacityOf(tester, DashboardScreen), 1);
    expect(opacityOf(tester, ReportsScreen), 0);
    await tearDownApp(tester);
  });

  testWidgets('compra con tarjeta a meses sin intereses', (tester) async {
    await pumpApp(tester, onboardingDone: true);
    await tester.runAsync(
      () => CardRepository(db).add(
        CreditCard(name: 'Oro', limitCents: 5000000, cutoffDay: 15, dueDay: 5, createdAt: DateTime.now()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(navItem('Agregar movimiento'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    for (final key in ['9', '0', '0']) {
      await tester.tap(find.bySemanticsLabel(key).last);
      await tester.pump();
    }
    await tester.tap(find.text('Oro'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('MSI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3 meses'));
    await tester.pumpAndSettle();
    expect(find.text(r'3 mensualidades de $300.00'), findsOneWidget);

    await tester.tap(find.text('Guardar a 3 MSI'));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    final charges = (await tester.runAsync(() => CardRepository(db).watchCharges().first))!;
    expect(charges.map((m) => m.amountCents), [30000, 30000, 30000]);
    expect(find.textContaining('Compra a 3 MSI guardada'), findsOneWidget);

    await tester.tap(navItem('Tarjetas'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Corte proyectado'), findsOneWidget);
    expect(find.text('Meses sin intereses'), findsOneWidget);
    await tearDownApp(tester);
  });
}
