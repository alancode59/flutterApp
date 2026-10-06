import 'package:flutter/foundation.dart';

/// Estado del teclado numérico del alta rápida. Es inmutable: cada tecla
/// devuelve un nuevo valor, o la misma instancia si la tecla no aplica
/// (así la UI puede sacudir el monto como retroalimentación).
@immutable
class AmountInput {
  const AmountInput([this.raw = '']);

  factory AmountInput.fromCents(int cents) {
    if (cents <= 0) return const AmountInput();
    final pesos = cents ~/ 100;
    final rest = cents % 100;
    if (rest == 0) return AmountInput('$pesos');
    return AmountInput('$pesos.${rest.toString().padLeft(2, '0')}');
  }

  static const maxIntegerDigits = 9;
  static const maxDecimals = 2;

  /// Lo que el usuario ha tecleado, por ejemplo `1250.5`.
  final String raw;

  bool get hasDot => raw.contains('.');
  bool get isEmpty => raw.isEmpty;

  String get _integerPart => hasDot ? raw.substring(0, raw.indexOf('.')) : raw;
  String get _decimalPart => hasDot ? raw.substring(raw.indexOf('.') + 1) : '';

  /// Agrega un dígito (`0`–`9`) o el punto decimal (`.`).
  AmountInput append(String key) {
    if (key == '.') {
      if (hasDot) return this;
      return AmountInput(raw.isEmpty ? '0.' : '$raw.');
    }
    assert(key.length == 1 && '0123456789'.contains(key), 'Tecla inválida: $key');
    if (hasDot) {
      if (_decimalPart.length >= maxDecimals) return this;
      return AmountInput('$raw$key');
    }
    if (raw == '0') return key == '0' ? this : AmountInput(key);
    if (_integerPart.length >= maxIntegerDigits) return this;
    return AmountInput('$raw$key');
  }

  AmountInput backspace() => raw.isEmpty ? this : AmountInput(raw.substring(0, raw.length - 1));

  int get cents {
    if (raw.isEmpty) return 0;
    final pesos = int.tryParse(_integerPart.isEmpty ? '0' : _integerPart) ?? 0;
    final decimals = int.tryParse(_decimalPart.padRight(2, '0')) ?? 0;
    return pesos * 100 + decimals;
  }

  /// `$1,250.5` tal cual se teclea (sin forzar dos decimales).
  String get display {
    if (raw.isEmpty) return r'$0';
    final grouped = _group(_integerPart.isEmpty ? '0' : _integerPart);
    return hasDot ? '\$$grouped.$_decimalPart' : '\$$grouped';
  }

  static String _group(String digits) {
    final buf = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buf.write(',');
      buf.write(digits[i]);
    }
    return buf.toString();
  }

  @override
  bool operator ==(Object other) => other is AmountInput && other.raw == raw;

  @override
  int get hashCode => raw.hashCode;
}

/// Convierte el texto de un campo de monto (`1,250.50`, `$80`) a centavos.
/// Devuelve null si no es un monto válido.
int? parseAmountToCents(String text) {
  final clean = text.replaceAll(RegExp(r'[\s,$]'), '');
  if (!RegExp(r'^\d{1,9}(\.\d{0,2})?$').hasMatch(clean)) return null;
  final parts = clean.split('.');
  final pesos = int.parse(parts[0]);
  final decimals = parts.length > 1 && parts[1].isNotEmpty ? int.parse(parts[1].padRight(2, '0')) : 0;
  return pesos * 100 + decimals;
}
