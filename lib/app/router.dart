import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/cards/presentation/cards_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/onboarding/presentation/splash_screen.dart';
import '../features/reports/presentation/reports_screen.dart';
import '../features/settings/presentation/more_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/transactions/presentation/transactions_screen.dart';
import 'shell/app_shell.dart';
import 'theme/app_tokens.dart';

part 'router.g.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const onboarding = '/bienvenida';
  static const home = '/inicio';
  static const transactions = '/movimientos';
  static const cards = '/tarjetas';
  static const reports = '/analisis';
  static const more = '/mas';
  static const settings = '/mas/ajustes';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, pageBuilder: (_, state) => _fadePage(state, const SplashScreen())),
      GoRoute(
        path: AppRoutes.onboarding,
        pageBuilder: (_, state) => _fadePage(state, const OnboardingScreen()),
      ),
      StatefulShellRoute(
        pageBuilder: (_, state, shell) => _fadePage(state, shell),
        navigatorContainerBuilder: (_, shell, children) => AppShell(shell: shell, children: children),
        branches: [
          _branch(AppRoutes.home, const DashboardScreen()),
          _branch(AppRoutes.transactions, const TransactionsScreen()),
          _branch(AppRoutes.cards, const CardsScreen()),
          _branch(AppRoutes.reports, const ReportsScreen()),
        ],
      ),
      GoRoute(
        path: AppRoutes.more,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const MoreScreen(),
        routes: [GoRoute(path: 'ajustes', builder: (_, _) => const SettingsScreen())],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}

StatefulShellBranch _branch(String path, Widget screen) => StatefulShellBranch(
  routes: [GoRoute(path: path, builder: (_, _) => screen)],
);

CustomTransitionPage<void> _fadePage(GoRouterState state, Widget child) => CustomTransitionPage<void>(
  key: state.pageKey,
  transitionDuration: AppDurations.slow,
  child: child,
  transitionsBuilder: (_, animation, _, child) => FadeTransition(
    opacity: CurvedAnimation(parent: animation, curve: AppCurves.standard),
    child: child,
  ),
);
