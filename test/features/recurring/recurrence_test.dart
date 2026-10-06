import 'package:finanzas/features/recurring/domain/recurrence.dart';
import 'package:finanzas/features/recurring/domain/recurring_rule.dart';
import 'package:finanzas/features/transactions/domain/movement.dart';
import 'package:flutter_test/flutter_test.dart';

List<DateTime> occ(Frequency f, DateTime start, DateTime from, DateTime to, {DateTime? end}) =>
    Recurrence.occurrences(frequency: f, start: start, end: end, from: from, to: to);

RecurringRule rule(Frequency f, DateTime start, {DateTime? last, DateTime? end, bool active = true}) =>
    RecurringRule(
      kind: MovementKind.expense,
      name: 'Prueba',
      amountCents: 100,
      categoryId: 1,
      frequency: f,
      startDate: start,
      endDate: end,
      lastGeneratedDate: last,
      active: active,
    );

void main() {
  group('semanal', () {
    test('cada 7 días desde el inicio', () {
      expect(occ(Frequency.weekly, DateTime(2026, 10, 1), DateTime(2026, 10, 1), DateTime(2026, 10, 20)), [
        DateTime(2026, 10, 1),
        DateTime(2026, 10, 8),
        DateTime(2026, 10, 15),
      ]);
    });

    test('respeta la fase cuando from cae entre ocurrencias', () {
      expect(occ(Frequency.weekly, DateTime(2026, 10, 1), DateTime(2026, 10, 9), DateTime(2026, 10, 22)), [
        DateTime(2026, 10, 15),
        DateTime(2026, 10, 22),
      ]);
    });

    test('cruza el cambio de horario sin desfasarse', () {
      final r = occ(Frequency.weekly, DateTime(2026, 3, 1), DateTime(2026, 3, 1), DateTime(2026, 4, 30));
      expect(r.every((d) => d.weekday == DateTime(2026, 3, 1).weekday && d.hour == 0), isTrue);
      expect(r.length, 9);
    });
  });

  group('quincenal', () {
    test('días 15 y último del mes', () {
      expect(occ(Frequency.biweekly, DateTime(2026, 1, 1), DateTime(2026, 1, 1), DateTime(2026, 2, 28)), [
        DateTime(2026, 1, 15),
        DateTime(2026, 1, 31),
        DateTime(2026, 2, 15),
        DateTime(2026, 2, 28),
      ]);
    });

    test('no genera antes del inicio', () {
      expect(occ(Frequency.biweekly, DateTime(2026, 10, 20), DateTime(2026, 10, 1), DateTime(2026, 11, 20)), [
        DateTime(2026, 10, 31),
        DateTime(2026, 11, 15),
      ]);
    });
  });

  group('mensual', () {
    test('día 31 se ajusta a meses cortos', () {
      expect(occ(Frequency.monthly, DateTime(2026, 1, 31), DateTime(2026, 1, 1), DateTime(2026, 4, 30)), [
        DateTime(2026, 1, 31),
        DateTime(2026, 2, 28),
        DateTime(2026, 3, 31),
        DateTime(2026, 4, 30),
      ]);
    });

    test('respeta la fecha de fin', () {
      expect(
        occ(
          Frequency.monthly,
          DateTime(2026, 1, 10),
          DateTime(2026, 1, 1),
          DateTime(2026, 12, 31),
          end: DateTime(2026, 3, 10),
        ),
        [DateTime(2026, 1, 10), DateTime(2026, 2, 10), DateTime(2026, 3, 10)],
      );
    });
  });

  test('anual con 29 de febrero', () {
    expect(occ(Frequency.yearly, DateTime(2028, 2, 29), DateTime(2028, 1, 1), DateTime(2030, 12, 31)), [
      DateTime(2028, 2, 29),
      DateTime(2029, 2, 28),
      DateTime(2030, 2, 28),
    ]);
  });

  test('rango vacío o invertido', () {
    expect(occ(Frequency.monthly, DateTime(2026, 5, 1), DateTime(2026, 1, 1), DateTime(2026, 4, 1)), isEmpty);
  });

  group('dueDates y nextDue', () {
    final today = DateTime(2026, 10, 5, 21, 30);

    test('sin generar: desde el inicio hasta hoy', () {
      expect(Recurrence.dueDates(rule(Frequency.monthly, DateTime(2026, 8, 5)), today), [
        DateTime(2026, 8, 5),
        DateTime(2026, 9, 5),
        DateTime(2026, 10, 5),
      ]);
    });

    test('continúa después de la última generación', () {
      final r = rule(Frequency.monthly, DateTime(2026, 8, 5), last: DateTime(2026, 9, 30));
      expect(Recurrence.dueDates(r, today), [DateTime(2026, 10, 5)]);
      expect(Recurrence.dueDates(r.copyWith(lastGeneratedDate: DateTime(2026, 10, 5)), today), isEmpty);
    });

    test('inactiva no genera', () {
      expect(
        Recurrence.dueDates(rule(Frequency.weekly, DateTime(2026, 1, 1), active: false), today),
        isEmpty,
      );
    });

    test('siguiente fecha pendiente', () {
      final r = rule(Frequency.biweekly, DateTime(2026, 10, 1), last: DateTime(2026, 10, 5));
      expect(Recurrence.nextDue(r), DateTime(2026, 10, 15));
      expect(
        Recurrence.nextDue(
          rule(
            Frequency.monthly,
            DateTime(2026, 1, 1),
            end: DateTime(2026, 3, 1),
            last: DateTime(2026, 3, 1),
          ),
        ),
        isNull,
      );
    });
  });
}
