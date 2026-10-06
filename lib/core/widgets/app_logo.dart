import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

/// Marca de la app: cuadro redondeado con tres barras ascendentes.
/// [progress] (0–1) permite animar el crecimiento de las barras en el splash.
class AppLogo extends StatelessWidget {
  const AppLogo({this.size = 72, this.progress = 1, super.key});

  final double size;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: context.scheme.primary,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: CustomPaint(painter: _BarsPainter(context.scheme.onPrimary, progress)),
    );
  }
}

class _BarsPainter extends CustomPainter {
  _BarsPainter(this.color, this.progress);

  final Color color;
  final double progress;

  static const _heights = [0.36, 0.56, 0.78];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final barWidth = size.width * 0.13;
    final gap = size.width * 0.08;
    final totalWidth = barWidth * 3 + gap * 2;
    final left = (size.width - totalWidth) / 2;
    final bottom = size.height * 0.74;
    final maxHeight = size.height * 0.5;

    for (var i = 0; i < _heights.length; i++) {
      // Cada barra arranca un poco después de la anterior.
      final t = ((progress * 1.6) - i * 0.3).clamp(0.0, 1.0);
      final h = maxHeight * _heights[i] / _heights.last * Curves.easeOutBack.transform(t);
      final x = left + i * (barWidth + gap);
      canvas.drawRRect(
        RRect.fromLTRBR(x, bottom - h, x + barWidth, bottom, Radius.circular(barWidth / 2)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BarsPainter old) => old.progress != progress || old.color != color;
}
