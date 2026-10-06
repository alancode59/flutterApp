import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';
import '../utils/formatters.dart';

/// Muestra un monto en MXN que "cuenta" desde el valor anterior al nuevo.
class AnimatedAmount extends StatelessWidget {
  const AnimatedAmount({
    required this.cents,
    required this.style,
    this.signed = false,
    this.duration = AppDurations.counter,
    super.key,
  });

  final int cents;
  final TextStyle? style;

  /// Antepone `+` a los montos positivos.
  final bool signed;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final format = signed ? Formatters.moneySigned : Formatters.money;
    final finalText = format(cents);

    return Semantics(
      label: finalText,
      excludeSemantics: true,
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: cents.toDouble()),
        duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : duration,
        curve: AppCurves.emphasized,
        builder: (context, value, _) => Text(
          format(value.round()),
          style: style,
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: false,
        ),
      ),
    );
  }
}
