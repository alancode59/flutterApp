import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';
import '../utils/formatters.dart';

/// Muestra un monto en MXN que "cuenta" desde el valor anterior al nuevo.
class AnimatedAmount extends StatelessWidget {
  const AnimatedAmount({
    required this.cents,
    required this.style,
    this.signed = false,
    this.smallCents = false,
    this.duration = AppDurations.counter,
    super.key,
  });

  final int cents;
  final TextStyle? style;

  /// Antepone `+` a los montos positivos.
  final bool signed;

  /// Dibuja los centavos más pequeños, como en los saldos principales.
  final bool smallCents;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final format = signed ? Formatters.moneySigned : Formatters.money;

    return Semantics(
      label: format(cents),
      excludeSemantics: true,
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: cents.toDouble()),
        duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : duration,
        curve: AppCurves.emphasized,
        builder: (context, value, _) =>
            MoneyText(format(value.round()), style: style, smallCents: smallCents),
      ),
    );
  }
}

/// Texto de un monto ya formateado; con [smallCents] los centavos van al 58 %.
class MoneyText extends StatelessWidget {
  const MoneyText(this.text, {required this.style, this.smallCents = true, super.key});

  final String text;
  final TextStyle? style;
  final bool smallCents;

  @override
  Widget build(BuildContext context) {
    final dot = text.lastIndexOf('.');
    if (!smallCents || dot < 0 || style?.fontSize == null) {
      return Text(text, style: style, maxLines: 1, overflow: TextOverflow.fade, softWrap: false);
    }
    final size = style!.fontSize!;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: text.substring(0, dot)),
          TextSpan(
            text: text.substring(dot),
            style: TextStyle(fontSize: size * 0.58, letterSpacing: -size * 0.01),
          ),
        ],
      ),
      style: style,
      maxLines: 1,
      overflow: TextOverflow.fade,
      softWrap: false,
    );
  }
}
