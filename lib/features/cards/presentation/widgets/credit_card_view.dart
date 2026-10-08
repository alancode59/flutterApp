import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/theme/app_typography.dart';
import '../../domain/card_style.dart';
import '../../domain/credit_card.dart';

/// Proporción de una tarjeta física (ISO/IEC 7810 ID-1).
const kCardAspectRatio = 1.586;

/// Tarjeta física dibujada: acabado sólido, chip, red y últimos 4 dígitos.
/// Todo escala con el ancho disponible.
class CreditCardView extends StatelessWidget {
  const CreditCardView({required this.card, this.heroTag, this.elevated = true, super.key});

  final CreditCard card;

  /// Si se indica, la tarjeta vuela entre pantallas con un Hero.
  final Object? heroTag;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final view = AspectRatio(
      aspectRatio: kCardAspectRatio,
      child: LayoutBuilder(
        builder: (context, c) => _CardFace(card: card, width: c.maxWidth, elevated: elevated),
      ),
    );
    if (heroTag == null) return view;
    return Hero(
      tag: heroTag!,
      // Durante el vuelo no hay Material de por medio: se le da uno transparente.
      flightShuttleBuilder: (_, animation, _, _, _) => Material(type: MaterialType.transparency, child: view),
      child: view,
    );
  }
}

class _CardFace extends StatelessWidget {
  const _CardFace({required this.card, required this.width, required this.elevated});

  final CreditCard card;
  final double width;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final style = card.style;
    final s = width / 340;
    final fg = style.foreground;
    final radius = BorderRadius.circular(22 * s);

    return Semantics(
      label:
          'Tarjeta ${card.name}${card.bank != null ? ' de ${card.bank}' : ''}'
          '${card.last4 != null ? ', terminación ${card.last4}' : ''}',
      container: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: style.color,
          borderRadius: radius,
          boxShadow: elevated
              ? [
                  BoxShadow(
                    color: style.color.withValues(alpha: 0.38),
                    blurRadius: 28 * s,
                    offset: Offset(0, 14 * s),
                    spreadRadius: -6 * s,
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: _PatternPainter(style))),
              // Borde fino que da sensación de material.
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    border: Border.all(color: fg.withValues(alpha: 0.08), width: 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22 * s, 20 * s, 22 * s, 18 * s),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (card.bank != null)
                                Text(
                                  card.bank!.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamily,
                                    fontSize: 11 * s,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.4 * s,
                                    color: fg.withValues(alpha: 0.7),
                                  ),
                                ),
                              Text(
                                card.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamily,
                                  fontSize: 19 * s,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.3 * s,
                                  color: fg,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.contactless_outlined, color: fg.withValues(alpha: 0.75), size: 24 * s),
                      ],
                    ),
                    const Spacer(),
                    _Chip(scale: s, light: style.isLight),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            '••••  ${card.last4 ?? '••••'}',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 16 * s,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.6 * s,
                              fontFeatures: AppTypography.tabular,
                              color: fg.withValues(alpha: 0.92),
                            ),
                          ),
                        ),
                        _NetworkMark(network: card.network, scale: s, color: fg),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Arcos concéntricos en la esquina: textura sin degradados.
class _PatternPainter extends CustomPainter {
  _PatternPainter(this.style);

  final CardStyle style;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = style.pattern
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.004;
    final center = Offset(size.width * 1.02, size.height * -0.1);
    for (var i = 1; i <= 7; i++) {
      canvas.drawCircle(center, size.width * 0.13 * i, paint);
    }
    // Un disco sólido muy tenue que da profundidad.
    canvas.drawCircle(
      Offset(size.width * 0.05, size.height * 1.15),
      size.width * 0.42,
      Paint()..color = style.pattern,
    );
  }

  @override
  bool shouldRepaint(_PatternPainter old) => old.style != style;
}

class _Chip extends StatelessWidget {
  const _Chip({required this.scale, required this.light});

  final double scale;
  final bool light;

  @override
  Widget build(BuildContext context) {
    final base = light ? const Color(0xFFBFA46A) : const Color(0xFFD9C38F);
    final line = Colors.black.withValues(alpha: 0.18);
    return Container(
      width: 42 * scale,
      height: 32 * scale,
      decoration: BoxDecoration(color: base, borderRadius: BorderRadius.circular(7 * scale)),
      child: CustomPaint(painter: _ChipLines(line)),
    );
  }
}

class _ChipLines extends CustomPainter {
  _ChipLines(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = math.max(0.8, size.width * 0.025);
    final w = size.width;
    final h = size.height;
    canvas
      ..drawLine(Offset(0, h * 0.35), Offset(w * 0.32, h * 0.35), p)
      ..drawLine(Offset(0, h * 0.65), Offset(w * 0.32, h * 0.65), p)
      ..drawLine(Offset(w * 0.68, h * 0.35), Offset(w, h * 0.35), p)
      ..drawLine(Offset(w * 0.68, h * 0.65), Offset(w, h * 0.65), p)
      ..drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTRB(w * 0.32, h * 0.2, w * 0.68, h * 0.8),
          Radius.circular(w * 0.06),
        ),
        p..style = PaintingStyle.stroke,
      );
  }

  @override
  bool shouldRepaint(_ChipLines old) => old.color != color;
}

class _NetworkMark extends StatelessWidget {
  const _NetworkMark({required this.network, required this.scale, required this.color});

  final CardNetwork network;
  final double scale;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final s = scale;
    return switch (network) {
      CardNetwork.visa => Text(
        'VISA',
        style: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: 22 * s,
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.italic,
          letterSpacing: -0.5 * s,
          color: color,
          height: 1,
        ),
      ),
      CardNetwork.mastercard => SizedBox(
        width: 46 * s,
        height: 28 * s,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: _Circle(size: 28 * s, color: const Color(0xFFEB001B)),
            ),
            Positioned(
              right: 0,
              child: _Circle(size: 28 * s, color: const Color(0xFFF79E1B).withValues(alpha: 0.9)),
            ),
          ],
        ),
      ),
      CardNetwork.amex => Container(
        padding: EdgeInsets.symmetric(horizontal: 6 * s, vertical: 3 * s),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1.4 * s),
          borderRadius: BorderRadius.circular(4 * s),
        ),
        child: Text(
          'AMEX',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 13 * s,
            fontWeight: FontWeight.w800,
            letterSpacing: 1 * s,
            color: color,
            height: 1,
          ),
        ),
      ),
      CardNetwork.other => const SizedBox.shrink(),
    };
  }
}

class _Circle extends StatelessWidget {
  const _Circle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}
