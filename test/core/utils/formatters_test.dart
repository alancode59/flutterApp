import 'package:finanzas/core/utils/formatters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() => initializeDateFormatting('es_MX'));

  group('montos', () {
    test('formatea centavos como MXN', () {
      expect(Formatters.money(123450), r'$1,234.50');
      expect(Formatters.money(0), r'$0.00');
      expect(Formatters.money(5), r'$0.05');
    });

    test('negativos y con signo', () {
      expect(Formatters.money(-9900), r'-$99.00');
      expect(Formatters.moneySigned(9900), r'+$99.00');
      expect(Formatters.moneySigned(-9900), r'-$99.00');
    });

    test('redondeado sin centavos', () {
      expect(Formatters.moneyRounded(123450), r'$1,235');
    });
  });

  group('fechas', () {
    final d = DateTime(2026, 10, 5);

    test('corta sin punto de abreviatura', () {
      expect(Formatters.date(d), '5 oct 2026');
      expect(Formatters.dayMonth(d), '5 oct');
    });

    test('larga', () {
      expect(Formatters.longDate(d), 'lunes, 5 de octubre');
    });
  });

  test('días relativos', () {
    final today = DateTime(2026, 10, 7, 18);
    expect(Formatters.relativeDays(DateTime(2026, 10, 7), today), 'hoy');
    expect(Formatters.relativeDays(DateTime(2026, 10, 8, 1), today), 'mañana');
    expect(Formatters.relativeDays(DateTime(2026, 10, 15), today), 'en 8 días');
    expect(Formatters.relativeDays(DateTime(2026, 10, 6), today), 'ayer');
    expect(Formatters.relativeDays(DateTime(2026, 10, 1), today), 'hace 6 días');
  });
}
