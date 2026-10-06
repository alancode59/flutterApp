import 'package:finanzas/features/transactions/domain/movement.dart';
import 'package:finanzas/features/transactions/domain/period.dart';
import 'package:finanzas/features/transactions/domain/period_summary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() => initializeDateFormatting('es_MX'));

  group('PeriodSelection', () {
    test('quincena y navegación', () {
      final p = PeriodSelection.quincena(DateTime(2026, 10, 20));
      expect(p.range, DateRange(DateTime(2026, 10, 16), DateTime(2026, 11, 1)));
      expect(p.label, '16 – 31 oct 2026');
      expect(p.next.range.start, DateTime(2026, 11, 1));
      expect(p.previous.range.start, DateTime(2026, 10, 1));
    });

    test('mes y cambio de año', () {
      final p = PeriodSelection.month(DateTime(2026, 12, 9));
      expect(p.range, DateRange(DateTime(2026, 12), DateTime(2027)));
      expect(p.label, 'Diciembre 2026');
      expect(p.next.range.start, DateTime(2027));
      expect(p.previous.label, 'Noviembre 2026');
    });

    test('rango personalizado incluye el último día y no se desplaza', () {
      final p = PeriodSelection.custom(DateRange.days(DateTime(2026, 9, 3), DateTime(2026, 10, 10)));
      expect(p.range.contains(DateTime(2026, 10, 10, 23, 59)), isTrue);
      expect(p.range.contains(DateTime(2026, 10, 11)), isFalse);
      expect(p.label, '3 sep – 10 oct 2026');
      expect(p.next, p);
      expect(p.canStep, isFalse);
    });

    test('ofType conserva la fecha de referencia', () {
      final p = PeriodSelection.ofType(PeriodType.month, DateTime(2026, 2, 20));
      expect(p.range.start, DateTime(2026, 2));
    });
  });

  group('PeriodSummary', () {
    Movement m(MovementKind k, int c, {bool unexpected = false}) => Movement(
      kind: k,
      amountCents: c,
      categoryId: 1,
      date: DateTime(2026, 10, 1),
      isUnexpected: unexpected,
    );

    test('suma ingresos, gastos e imprevistos', () {
      final s = PeriodSummary.of([
        m(MovementKind.income, 1425000),
        m(MovementKind.expense, 48650),
        m(MovementKind.expense, 120000, unexpected: true),
      ]);
      expect(s.incomeCents, 1425000);
      expect(s.expenseCents, 168650);
      expect(s.unexpectedCents, 120000);
      expect(s.balanceCents, 1256350);
    });

    test('balance negativo', () {
      expect(PeriodSummary.of([m(MovementKind.expense, 500)]).balanceCents, -500);
    });

    test('vacío', () => expect(PeriodSummary.of(const []), const PeriodSummary()));
  });
}
