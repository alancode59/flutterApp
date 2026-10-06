import 'package:finanzas/app/app.dart';
import 'package:finanzas/app/shell/app_nav_bar.dart';
import 'package:finanzas/features/settings/data/drift_settings_repository.dart';
import 'package:finanzas/features/settings/domain/app_settings.dart';
import 'package:finanzas/features/settings/domain/settings_repository.dart';
import 'package:finanzas/features/settings/presentation/settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Repositorio en memoria: Drift usa E/S real, que no avanza con el reloj falso de testWidgets.
class _MemorySettingsRepository implements SettingsRepository {
  AppSettings saved = const AppSettings();

  @override
  Future<AppSettings> load() async => saved;

  @override
  Future<void> save(AppSettings settings) async => saved = settings;
}

void main() {
  setUpAll(() => initializeDateFormatting('es_MX'));

  Future<_MemorySettingsRepository> pumpApp(WidgetTester tester, {required bool onboardingDone}) async {
    final repo = _MemorySettingsRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(repo),
          initialSettingsProvider.overrideWithValue(AppSettings(onboardingCompleted: onboardingDone)),
        ],
        child: const FinanzasApp(),
      ),
    );
    // Deja terminar el splash y la transición.
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    return repo;
  }

  Finder navItem(String label) =>
      find.descendant(of: find.byType(AppNavBar), matching: find.bySemanticsLabel(label));

  testWidgets('primera vez muestra la bienvenida y al omitirla llega a Inicio', (tester) async {
    final repo = await pumpApp(tester, onboardingDone: false);
    expect(find.text('Tu dinero, claro y en un solo lugar'), findsOneWidget);

    await tester.tap(find.text('Omitir'));
    await tester.pumpAndSettle();
    expect(find.text('Te queda esta quincena'), findsOneWidget);
    expect(repo.saved.onboardingCompleted, isTrue);
  });

  testWidgets('con la bienvenida vista abre directo en Inicio', (tester) async {
    await pumpApp(tester, onboardingDone: true);
    expect(find.text('Te queda esta quincena'), findsOneWidget);
  });

  testWidgets('la barra inferior cambia de sección y abre el alta rápida', (tester) async {
    await pumpApp(tester, onboardingDone: true);

    await tester.tap(navItem('Tarjetas'));
    await tester.pumpAndSettle();
    expect(find.text('Agrega tu primera tarjeta'), findsOneWidget);

    await tester.tap(navItem('Movimientos'));
    await tester.pumpAndSettle();
    expect(find.text('Tu historial está vacío'), findsOneWidget);

    await tester.tap(navItem('Agregar movimiento'));
    await tester.pumpAndSettle();
    expect(find.text('Nuevo movimiento'), findsOneWidget);
  });
}
