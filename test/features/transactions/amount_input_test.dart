import 'package:finanzas/features/transactions/domain/amount_input.dart';
import 'package:flutter_test/flutter_test.dart';

AmountInput type(String keys) => keys.split('').fold(const AmountInput(), (a, k) => a.append(k));

void main() {
  group('AmountInput', () {
    test('vacío muestra \$0 y vale 0', () {
      expect(const AmountInput().display, r'$0');
      expect(const AmountInput().cents, 0);
    });

    test('enteros y separador de miles', () {
      expect(type('1250').display, r'$1,250');
      expect(type('1250').cents, 125000);
      expect(type('1234567').display, r'$1,234,567');
    });

    test('decimales con máximo dos dígitos', () {
      expect(type('12.5').cents, 1250);
      expect(type('12.50').cents, 1250);
      expect(type('12.505').raw, '12.50');
      expect(type('12.5').display, r'$12.5');
    });

    test('un solo punto y punto inicial agrega cero', () {
      expect(type('.5').raw, '0.5');
      expect(type('1..2').raw, '1.2');
    });

    test('no acepta ceros a la izquierda', () {
      expect(type('007').raw, '7');
      expect(type('0').append('0').raw, '0');
    });

    test('limita la parte entera a 9 dígitos', () {
      final full = type('123456789');
      expect(identical(full.append('1'), full), isTrue);
      expect(full.append('.').append('9').cents, 12345678990);
    });

    test('teclas rechazadas regresan la misma instancia', () {
      final a = type('5.25');
      expect(identical(a.append('1'), a), isTrue);
      expect(identical(const AmountInput().backspace(), const AmountInput()), isTrue);
    });

    test('backspace', () {
      expect(type('12.5').backspace().raw, '12.');
      expect(type('12.').backspace().raw, '12');
    });

    test('fromCents', () {
      expect(AmountInput.fromCents(125000).raw, '1250');
      expect(AmountInput.fromCents(125050).raw, '1250.50');
      expect(AmountInput.fromCents(5).raw, '0.05');
      expect(AmountInput.fromCents(0).raw, '');
    });
  });

  group('parseAmountToCents', () {
    test('acepta formatos comunes', () {
      expect(parseAmountToCents('1,250.50'), 125050);
      expect(parseAmountToCents(r'$80'), 8000);
      expect(parseAmountToCents('0.5'), 50);
      expect(parseAmountToCents(' 99. '), 9900);
    });

    test('rechaza texto inválido', () {
      expect(parseAmountToCents(''), isNull);
      expect(parseAmountToCents('abc'), isNull);
      expect(parseAmountToCents('1.234'), isNull);
      expect(parseAmountToCents('-5'), isNull);
    });
  });
}
