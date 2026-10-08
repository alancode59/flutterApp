import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// Acabados sólidos (sin degradados) para las tarjetas físicas.
@immutable
class CardStyle {
  const CardStyle(this.name, this.color);

  final String name;
  final Color color;

  /// Texto e íconos sobre la tarjeta: oscuro en acabados claros.
  bool get isLight => color.computeLuminance() > 0.45;

  Color get foreground => isLight ? const Color(0xFF0E1320) : const Color(0xFFFFFFFF);

  /// Trazos decorativos: el mismo tono un poco más claro u oscuro.
  Color get pattern => isLight ? const Color(0x14000000) : const Color(0x1AFFFFFF);

  static const all = [
    CardStyle('Obsidiana', Color(0xFF16181D)),
    CardStyle('Medianoche', Color(0xFF1B2D52)),
    CardStyle('Cian', Color(0xFF0B8FAD)),
    CardStyle('Esmeralda', Color(0xFF0E7A6A)),
    CardStyle('Violeta', Color(0xFF5B3FD1)),
    CardStyle('Coral', Color(0xFFE0574F)),
    CardStyle('Rosa', Color(0xFFD4558A)),
    CardStyle('Oro', Color(0xFFD9B45A)),
    CardStyle('Plata', Color(0xFFD5DBE3)),
    CardStyle('Grafito', Color(0xFF41464F)),
  ];

  static CardStyle byIndex(int i) => all[i.clamp(0, all.length - 1)];
}
