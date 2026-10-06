import 'package:flutter/services.dart';

/// Retroalimentación háptica con significado consistente en toda la app.
/// En web y escritorio las llamadas son inofensivas (no hacen nada).
abstract final class Haptics {
  /// Tocar un control (tab, chip, tecla).
  static Future<void> tap() => HapticFeedback.selectionClick();

  /// Acción principal (abrir alta rápida, cambiar de página).
  static Future<void> light() => HapticFeedback.lightImpact();

  /// Guardado exitoso.
  static Future<void> success() => HapticFeedback.mediumImpact();

  /// Acción destructiva o error.
  static Future<void> warning() => HapticFeedback.heavyImpact();
}
