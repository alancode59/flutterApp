import 'package:finanzas/core/domain/quincena.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() => initializeDateFormatting('es_MX'));

  group('Quincena.of', () {
    test('del 1 al 15 es la primera quincena', () {
      final q = Quincena.of(DateTime(2026, 10, 15, 23, 59));
      expect(q.start, DateTime(2026, 10, 1));
      expect(q.endExclusive, DateTime(2026, 10, 16));
      expect(q.lastDay, DateTime(2026, 10, 15));
      expect(q.isFirstHalf, isTrue);
    });

    test('del 16 al fin de mes es la segunda quincena', () {
      final q = Quincena.of(DateTime(2026, 10, 16));
      expect(q.start, DateTime(2026, 10, 16));
      expect(q.lastDay, DateTime(2026, 10, 31));
      expect(q.lengthInDays, 16);
    });

    test('febrero en año bisiesto termina el 29', () {
      final q = Quincena.of(DateTime(2028, 2, 20));
      expect(q.lastDay, DateTime(2028, 2, 29));
      expect(q.lengthInDays, 14);
    });

    test('febrero en año normal termina el 28', () {
      expect(Quincena.of(DateTime(2026, 2, 28)).lastDay, DateTime(2026, 2, 28));
    });
  });

  group('navegación entre quincenas', () {
    test('next cruza de diciembre a enero', () {
      final next = Quincena.of(DateTime(2026, 12, 20)).next;
      expect(next.start, DateTime(2027, 1, 1));
      expect(next.lastDay, DateTime(2027, 1, 15));
    });

    test('previous cruza de enero a diciembre', () {
      final prev = Quincena.of(DateTime(2027, 1, 3)).previous;
      expect(prev.start, DateTime(2026, 12, 16));
      expect(prev.lastDay, DateTime(2026, 12, 31));
    });

    test('next y previous son inversos', () {
      final q = Quincena.of(DateTime(2026, 3, 10));
      expect(q.next.previous, q);
      expect(q.previous.next, q);
    });
  });

  group('contains y daysLeft', () {
    final q = Quincena.of(DateTime(2026, 10, 5));

    test('incluye el último instante del día 15 y excluye el 16', () {
      expect(q.contains(DateTime(2026, 10, 1)), isTrue);
      expect(q.contains(DateTime(2026, 10, 15, 23, 59, 59)), isTrue);
      expect(q.contains(DateTime(2026, 10, 16)), isFalse);
      expect(q.contains(DateTime(2026, 9, 30, 23, 59)), isFalse);
    });

    test('cuenta el día de hoy', () {
      expect(q.daysLeft(DateTime(2026, 10, 1)), 15);
      expect(q.daysLeft(DateTime(2026, 10, 15, 22)), 1);
      expect(q.daysLeft(DateTime(2026, 10, 20)), 0);
    });
  });

  test('label en español', () {
    expect(Quincena.of(DateTime(2026, 10, 5)).label, '1 – 15 oct');
    expect(Quincena.of(DateTime(2026, 10, 25)).label, '16 – 31 oct');
  });
}
