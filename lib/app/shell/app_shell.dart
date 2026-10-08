import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/haptics.dart';
import '../../features/transactions/presentation/quick_add_sheet.dart';
import '../theme/app_tokens.dart';
import 'app_nav_bar.dart';

const _destinations = [
  NavDestination(label: 'Inicio', icon: Icons.home_outlined, selectedIcon: Icons.home_rounded),
  NavDestination(
    label: 'Movimientos',
    icon: Icons.receipt_long_outlined,
    selectedIcon: Icons.receipt_long_rounded,
  ),
  NavDestination(
    label: 'Tarjetas',
    icon: Icons.credit_card_outlined,
    selectedIcon: Icons.credit_card_rounded,
  ),
  NavDestination(label: 'Análisis', icon: Icons.insights_outlined, selectedIcon: Icons.insights_rounded),
];

/// Contenedor de las 4 secciones principales. Cada sección conserva su estado
/// (scroll, navegación interna) al cambiar de pestaña.
class AppShell extends StatelessWidget {
  const AppShell({required this.shell, required this.children, super.key});

  final StatefulNavigationShell shell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // La barra flota sobre el contenido; las listas reciben su alto como padding inferior.
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _BranchSwitcher(index: shell.currentIndex, children: children),
      bottomNavigationBar: AppNavBar(
        destinations: _destinations,
        currentIndex: shell.currentIndex,
        onSelect: (i) {
          if (i != shell.currentIndex) Haptics.tap();
          // Tocar la pestaña activa regresa a su pantalla inicial.
          shell.goBranch(i, initialLocation: i == shell.currentIndex);
        },
        onAdd: () => showQuickAddSheet(context),
      ),
    );
  }
}

/// Transición "fade through": la pestaña nueva aparece con un leve zoom.
class _BranchSwitcher extends StatelessWidget {
  const _BranchSwitcher({required this.index, required this.children});

  final int index;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final duration = MediaQuery.disableAnimationsOf(context) ? Duration.zero : AppDurations.medium;

    return Stack(
      fit: StackFit.expand,
      children: [
        for (var i = 0; i < children.length; i++)
          _Branch(active: i == index, duration: duration, child: children[i]),
      ],
    );
  }
}

class _Branch extends StatelessWidget {
  const _Branch({required this.active, required this.duration, required this.child});

  final bool active;
  final Duration duration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // TickerMode va por dentro de las animaciones: si las envolviera, la pestaña
    // saliente congelaría su fade y seguiría tapando a la nueva.
    return IgnorePointer(
      ignoring: !active,
      child: ExcludeSemantics(
        excluding: !active,
        child: AnimatedOpacity(
          opacity: active ? 1 : 0,
          duration: duration,
          curve: AppCurves.standard,
          child: AnimatedScale(
            scale: active ? 1 : 0.98,
            duration: duration,
            curve: AppCurves.standard,
            child: TickerMode(enabled: active, child: child),
          ),
        ),
      ),
    );
  }
}
