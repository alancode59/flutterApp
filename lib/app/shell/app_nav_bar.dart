import 'package:flutter/material.dart';

import '../../core/services/haptics.dart';
import '../../core/widgets/pressable.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

class NavDestination {
  const NavDestination({required this.label, required this.icon, required this.selectedIcon});

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// Barra inferior con 4 secciones y el botón central para agregar movimientos.
class AppNavBar extends StatelessWidget {
  const AppNavBar({
    required this.destinations,
    required this.currentIndex,
    required this.onSelect,
    required this.onAdd,
    super.key,
  }) : assert(destinations.length == 4);

  final List<NavDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    Widget item(int i) => Expanded(
      child: _NavItem(destination: destinations[i], selected: i == currentIndex, onTap: () => onSelect(i)),
    );

    // Las etiquetas crecen con el texto del sistema, pero con un tope para no romper la barra.
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.3,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.scheme.surfaceContainer,
          border: Border(top: BorderSide(color: context.scheme.outlineVariant, width: 0.5)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 68,
            child: Row(
              children: [
                item(0),
                item(1),
                Expanded(
                  child: Center(child: _AddButton(onTap: onAdd)),
                ),
                item(2),
                item(3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.destination, required this.selected, required this.onTap});

  final NavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final target = selected ? context.scheme.primary : context.colors.textSecondary;

    return Semantics(
      selected: selected,
      button: true,
      label: destination.label,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: 36,
        highlightShape: BoxShape.rectangle,
        containedInkWell: false,
        child: TweenAnimationBuilder<Color?>(
          tween: ColorTween(end: target),
          duration: AppDurations.medium,
          builder: (context, color, _) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: selected ? 1.08 : 1,
                duration: AppDurations.medium,
                curve: AppCurves.spring,
                child: Icon(selected ? destination.selectedIcon : destination.icon, color: color, size: 26),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                destination.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.labelSmall?.copyWith(
                  color: color,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Agregar movimiento',
      child: Pressable(
        semanticLabel: 'Agregar movimiento',
        scale: 0.88,
        haptic: false,
        onTap: () {
          Haptics.light();
          onTap();
        },
        child: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: context.scheme.primary,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Icon(Icons.add_rounded, size: 30, color: context.scheme.onPrimary),
        ),
      ),
    );
  }
}
