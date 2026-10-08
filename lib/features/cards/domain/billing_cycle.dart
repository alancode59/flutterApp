import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../../../core/utils/formatters.dart';

/// Periodo de facturación de una tarjeta: del día siguiente al corte anterior
/// hasta el día de corte (ambos incluidos). La fecha límite de pago es el
/// primer [dueDay] posterior al corte.
@immutable
class BillingCycle {
  const BillingCycle._({
    required this.start,
    required this.cutoff,
    required this.dueDate,
    required this.cutoffDay,
    required this.dueDay,
  });

  factory BillingCycle.endingIn(int year, int month, {required int cutoffDay, required int dueDay}) {
    final cutoff = dayIn(year, month, cutoffDay);
    final previousCutoff = dayIn(year, month - 1, cutoffDay);
    return BillingCycle._(
      start: DateTime(previousCutoff.year, previousCutoff.month, previousCutoff.day + 1),
      cutoff: cutoff,
      dueDate: _dueAfter(cutoff, dueDay),
      cutoffDay: cutoffDay,
      dueDay: dueDay,
    );
  }

  /// Ciclo al que pertenece una compra hecha en [date].
  factory BillingCycle.containing(DateTime date, {required int cutoffDay, required int dueDay}) {
    final day = DateTime(date.year, date.month, date.day);
    final thisMonth = dayIn(day.year, day.month, cutoffDay);
    return day.isAfter(thisMonth)
        ? BillingCycle.endingIn(day.year, day.month + 1, cutoffDay: cutoffDay, dueDay: dueDay)
        : BillingCycle.endingIn(day.year, day.month, cutoffDay: cutoffDay, dueDay: dueDay);
  }

  /// Primer día del ciclo (inclusivo).
  final DateTime start;

  /// Día de corte (inclusivo).
  final DateTime cutoff;

  final DateTime dueDate;
  final int cutoffDay;
  final int dueDay;

  /// Primer instante después del corte, para consultas por rango.
  DateTime get endExclusive => DateTime(cutoff.year, cutoff.month, cutoff.day + 1);

  BillingCycle get previous =>
      BillingCycle.endingIn(cutoff.year, cutoff.month - 1, cutoffDay: cutoffDay, dueDay: dueDay);

  BillingCycle get next =>
      BillingCycle.endingIn(cutoff.year, cutoff.month + 1, cutoffDay: cutoffDay, dueDay: dueDay);

  bool contains(DateTime date) => !date.isBefore(start) && date.isBefore(endExclusive);

  /// `16 sep – 15 oct`
  String get label => '${Formatters.dayMonth(start)} – ${Formatters.dayMonth(cutoff)}';

  /// El día [day] del mes, ajustado al último día en meses más cortos.
  /// Acepta meses fuera de rango (0, 13…) como `DateTime`.
  static DateTime dayIn(int year, int month, int day) {
    final lastDay = DateTime(year, month + 1, 0).day;
    return DateTime(year, month, math.min(day, lastDay));
  }

  static DateTime _dueAfter(DateTime cutoff, int dueDay) {
    final sameMonth = dayIn(cutoff.year, cutoff.month, dueDay);
    return sameMonth.isAfter(cutoff) ? sameMonth : dayIn(cutoff.year, cutoff.month + 1, dueDay);
  }

  @override
  bool operator ==(Object other) =>
      other is BillingCycle &&
      other.cutoff == cutoff &&
      other.cutoffDay == cutoffDay &&
      other.dueDay == dueDay;

  @override
  int get hashCode => Object.hash(cutoff, cutoffDay, dueDay);

  @override
  String toString() => 'BillingCycle($start – $cutoff, paga $dueDate)';
}
