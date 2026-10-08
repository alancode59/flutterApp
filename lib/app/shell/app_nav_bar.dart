import 'dart:ui';

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

/// Barra inferior flotante de cristal: 4 secciones y el botón central para
/// agregar movimientos. El contenido se ve desenfocado por debajo.
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

  static const height = 66.0;

  @override
  Widget build(BuildContext context) {
    Widget item(int i) => Expanded(
      child: _NavItem(destination: destinations[i], selected: i == currentIndex, onTap: () => onSelect(i)),
    );
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final isDark = context.theme.brightness == Brightness.dark;

    // Las etiquetas crecen con el texto del sistema, pero con un tope para no romper la barra.
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.2,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.sm,
          0,
          AppSpacing.sm,
          bottomInset > 0 ? bottomInset - 8 : AppSpacing.sm,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.12),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: context.colors.surfaceHigh.withValues(alpha: isDark ? 0.72 : 0.82),
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(
                    color: (isDark ? Colors.white : Colors.black).withValues(alpha: isDark ? 0.08 : 0.06),
                    width: 0.8,
                  ),
                ),
                child: Row(
                  children: [
                    item(0),
                    item(1),
                    SizedBox(
                      width: 72,
                      child: Center(child: _AddButton(onTap: onAdd)),
                    ),
                    item(2),
                    item(3),
                  ],
                ),
              ),
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
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: TweenAnimationBuilder<Color?>(
          tween: ColorTween(end: target),
          duration: AppDurations.medium,
          builder: (context, color, _) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: selected ? 1.06 : 1,
                duration: AppDurations.medium,
                curve: AppCurves.spring,
                child: Icon(selected ? destination.selectedIcon : destination.icon, color: color, size: 24),
              ),
              const SizedBox(height: 3),
              Text(
                destination.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.labelSmall?.copyWith(
                  color: color,
                  fontSize: 10.5,
                  letterSpacing: 0,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              // Punto indicador de la sección activa.
              AnimatedContainer(
                duration: AppDurations.medium,
                curve: AppCurves.emphasized,
                width: selected ? 4 : 0,
                height: 4,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: context.scheme.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: context.scheme.primary.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Icons.add_rounded, size: 28, color: context.scheme.onPrimary),
        ),
      ),
    );
  }
}
