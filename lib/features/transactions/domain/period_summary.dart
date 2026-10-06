import 'package:flutter/foundation.dart';

import 'movement.dart';

/// Totales de un conjunto de movimientos.
@immutable
class PeriodSummary {
  const PeriodSummary({this.incomeCents = 0, this.expenseCents = 0, this.unexpectedCents = 0});

  factory PeriodSummary.of(Iterable<Movement> movements) {
    var income = 0;
    var expense = 0;
    var unexpected = 0;
    for (final m in movements) {
      if (m.isExpense) {
        expense += m.amountCents;
        if (m.isUnexpected) unexpected += m.amountCents;
      } else {
        income += m.amountCents;
      }
    }
    return PeriodSummary(incomeCents: income, expenseCents: expense, unexpectedCents: unexpected);
  }

  final int incomeCents;
  final int expenseCents;

  /// Parte de [expenseCents] marcada como imprevista.
  final int unexpectedCents;

  /// Ingresos menos gastos (puede ser negativo).
  int get balanceCents => incomeCents - expenseCents;

  @override
  bool operator ==(Object other) =>
      other is PeriodSummary &&
      other.incomeCents == incomeCents &&
      other.expenseCents == expenseCents &&
      other.unexpectedCents == unexpectedCents;

  @override
  int get hashCode => Object.hash(incomeCents, expenseCents, unexpectedCents);

  @override
  String toString() => 'PeriodSummary(+$incomeCents, -$expenseCents, imprevistos $unexpectedCents)';
}
