import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/recurring/data/recurring_repository.dart';
import '../features/settings/presentation/settings_controller.dart';
import 'router.dart';
import 'theme/app_palette.dart';
import 'theme/app_theme.dart';

const appLocale = Locale('es', 'MX');

class FinanzasApp extends ConsumerStatefulWidget {
  const FinanzasApp({super.key});

  @override
  ConsumerState<FinanzasApp> createState() => _FinanzasAppState();
}

class _FinanzasAppState extends ConsumerState<FinanzasApp> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    // Si la app queda abierta de un día a otro, al volver se registran los recurrentes del día.
    _lifecycle = AppLifecycleListener(onResume: _generateRecurring);
  }

  Future<void> _generateRecurring() async {
    try {
      await ref.read(recurringRepositoryProvider).generateDue(DateTime.now());
    } catch (e) {
      debugPrint('No se pudieron generar los recurrentes: $e');
    }
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final palette = AppPalette.byId(settings.palette);

    return MaterialApp.router(
      title: 'Finanzas',
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
      theme: AppTheme.light(palette),
      darkTheme: AppTheme.dark(palette),
      themeMode: settings.themeMode,
      themeAnimationDuration: const Duration(milliseconds: 300),
      locale: appLocale,
      supportedLocales: const [appLocale],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // Respeta el tamaño de texto del sistema con un tope que no rompa el diseño.
      builder: (context, child) => MediaQuery.withClampedTextScaling(maxScaleFactor: 2, child: child!),
    );
  }
}
