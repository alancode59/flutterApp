import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_tokens.dart';
import '../services/haptics.dart';

/// Píldora de filtro de una sola selección.
class FilterPill extends StatelessWidget {
  const FilterPill({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
    this.dotColor,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  /// Punto de color antes del texto (por ejemplo, el color de una tarjeta).
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? context.scheme.onPrimary : context.scheme.onSurface;
    return Semantics(
      selected: selected,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!selected) Haptics.tap();
          onTap();
        },
        child: AnimatedContainer(
          duration: AppDurations.medium,
          curve: AppCurves.standard,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? context.scheme.primary : context.colors.surfaceHigh,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (dotColor != null) ...[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: fg.withValues(alpha: 0.4), width: 0.8),
                  ),
                ),
                const SizedBox(width: 6),
              ] else if (icon != null) ...[
                Icon(icon, size: 16, color: fg),
                const SizedBox(width: 6),
              ],
              AnimatedDefaultTextStyle(
                duration: AppDurations.medium,
                style: context.text.labelLarge!.copyWith(fontSize: 13.5, color: fg),
                child: Text(label, maxLines: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
