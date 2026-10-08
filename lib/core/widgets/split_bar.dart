import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_tokens.dart';

/// Barra horizontal dividida en segmentos proporcionales a [values].
/// Crece desde la izquierda al aparecer.
class SplitBar extends StatelessWidget {
  const SplitBar({required this.values, required this.colors, this.height = 8, super.key})
    : assert(values.length == colors.length);

  final List<int> values;
  final List<Color> colors;
  final double height;

  @override
  Widget build(BuildContext context) {
    final total = values.fold<int>(0, (a, b) => a + b);
    final visible = [
      for (var i = 0; i < values.length; i++)
        if (values[i] > 0) i,
    ];

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: context.colors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: total == 0
          ? null
          : TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : AppDurations.counter,
              curve: AppCurves.emphasized,
              builder: (context, t, child) =>
                  FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: t, child: child),
              child: Row(
                children: [
                  for (final (n, i) in visible.indexed) ...[
                    if (n > 0) const SizedBox(width: 3),
                    Expanded(
                      // Mínimo visible aunque el valor sea muy pequeño.
                      flex: (values[i] * 1000 ~/ total).clamp(20, 1000),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors[i],
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
