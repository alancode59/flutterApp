import 'package:finanzas/features/cards/domain/billing_cycle.dart';
import 'package:flutter_test/flutter_test.dart';

BillingCycle cycle(DateTime d, {int cutoff = 15, int due = 5}) =>
    BillingCycle.containing(d, cutoffDay: cutoff, dueDay: due);

void main() {
  group('ciclo que contiene una fecha', () {
    test('antes del corte cae en el corte de este mes', () {
      final c = cycle(DateTime(2026, 10, 7, 18, 30));
      expect(c.start, DateTime(2026, 9, 16));
      expect(c.cutoff, DateTime(2026, 10, 15));
    });

    test('el día de corte todavía pertenece a ese corte', () {
      expect(cycle(DateTime(2026, 10, 15, 23, 59)).cutoff, DateTime(2026, 10, 15));
    });

    test('un día después del corte pasa al siguiente', () {
      final c = cycle(DateTime(2026, 10, 16));
      expect(c.start, DateTime(2026, 10, 16));
      expect(c.cutoff, DateTime(2026, 11, 15));
    });

    test('cruza de año', () {
      final c = cycle(DateTime(2026, 12, 20));
      expect(c.cutoff, DateTime(2027, 1, 15));
      expect(c.dueDate, DateTime(2027, 2, 5));
    });
  });

  group('fecha límite de pago', () {
    test('si el día de pago es menor al de corte, es el mes siguiente', () {
      expect(cycle(DateTime(2026, 10, 1)).dueDate, DateTime(2026, 11, 5));
    });

    test('si el día de pago es mayor al de corte, es el mismo mes', () {
      final c = cycle(DateTime(2026, 10, 1), cutoff: 3, due: 23);
      expect(c.cutoff, DateTime(2026, 10, 3));
      expect(c.dueDate, DateTime(2026, 10, 23));
    });

    test('mismo día de corte y de pago: el del mes siguiente', () {
      expect(cycle(DateTime(2026, 10, 1), cutoff: 10, due: 10).dueDate, DateTime(2026, 11, 10));
    });
  });

  group('meses cortos', () {
    test('corte día 31 en febrero usa el último día', () {
      final c = cycle(DateTime(2026, 2, 10), cutoff: 31, due: 20);
      expect(c.start, DateTime(2026, 2, 1));
      expect(c.cutoff, DateTime(2026, 2, 28));
      expect(c.dueDate, DateTime(2026, 3, 20));
    });

    test('año bisiesto', () {
      expect(cycle(DateTime(2028, 2, 29), cutoff: 30).cutoff, DateTime(2028, 2, 29));
    });

    test('después del corte del 30 de abril sigue el 30 de mayo', () {
      final c = cycle(DateTime(2026, 5, 1), cutoff: 31);
      expect(c.start, DateTime(2026, 5, 1));
      expect(c.cutoff, DateTime(2026, 5, 31));
    });

    test('fecha límite el día 31 en un mes de 30 días', () {
      expect(cycle(DateTime(2026, 4, 2), cutoff: 10, due: 31).dueDate, DateTime(2026, 4, 30));
    });
  });

  test('anterior y siguiente encadenan sin huecos', () {
    final c = cycle(DateTime(2026, 3, 5), cutoff: 31);
    expect(c.previous.endExclusive, c.start);
    expect(c.endExclusive, c.next.start);
    expect(c.contains(DateTime(2026, 3, 31, 22)), isTrue);
    expect(c.contains(DateTime(2026, 4, 1)), isFalse);
  });
}
