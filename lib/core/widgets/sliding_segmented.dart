import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_tokens.dart';
import '../services/haptics.dart';

class Segment<T> {
  const Segment(this.value, this.label, {this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// Control segmentado con un indicador que se desliza entre opciones
/// del mismo ancho. Ocupa todo el ancho disponible.
class SlidingSegmented<T> extends StatelessWidget {
  const SlidingSegmented({
    required this.segments,
    required this.selected,
    required this.onChanged,
    this.height = 40,
    this.compact = false,
    super.key,
  });

  final List<Segment<T>> segments;
  final T selected;
  final ValueChanged<T> onChanged;
  final double height;

  /// Ajusta el ancho al contenido en vez de ocupar todo el espacio.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final index = segments.indexWhere((s) => s.value == selected);

    Widget track(double width) {
      final segmentWidth = (width - 8) / segments.length;
      return Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: context.colors.surfaceHigh,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Stack(
          children: [
            if (index >= 0)
              AnimatedPositioned(
                duration: AppDurations.medium,
                curve: AppCurves.emphasized,
                left: segmentWidth * index,
                top: 0,
                bottom: 0,
                width: segmentWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.scheme.primary,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
              ),
            Row(
              children: [
                for (final (i, s) in segments.indexed)
                  SizedBox(
                    width: segmentWidth,
                    child: Semantics(
                      selected: i == index,
                      button: true,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (s.value != selected) Haptics.tap();
                          onChanged(s.value);
                        },
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: AppDurations.medium,
                            style: context.text.labelLarge!.copyWith(
                              fontSize: 14,
                              color: i == index ? context.scheme.onPrimary : context.colors.textSecondary,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (s.icon != null) ...[
                                      Icon(
                                        s.icon,
                                        size: 16,
                                        color: i == index
                                            ? context.scheme.onPrimary
                                            : context.colors.textSecondary,
                                      ),
                                      const SizedBox(width: 6),
                                    ],
                                    Text(s.label, maxLines: 1),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    }

    if (compact) return track(segments.length * 116.0 + 8);
    return LayoutBuilder(builder: (context, c) => track(c.maxWidth));
  }
}
