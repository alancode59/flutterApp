import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../../core/domain/quincena.dart';

/// Rango de fechas con inicio inclusivo y fin exclusivo.
@immutable
class DateRange {
  const DateRange(this.start, this.endExclusive);

  /// Rango de días completos: de [first] a [last], ambos incluidos.
  factory DateRange.days(DateTime first, DateTime last) =>
      DateRange(DateTime(first.year, first.month, first.day), DateTime(last.year, last.month, last.day + 1));

  final DateTime start;
  final DateTime endExclusive;

  DateTime get lastDay => endExclusive.subtract(const Duration(days: 1));

  bool contains(DateTime d) => !d.isBefore(start) && d.isBefore(endExclusive);

  @override
  bool operator ==(Object other) =>
      other is DateRange && other.start == start && other.endExclusive == endExclusive;

  @override
  int get hashCode => Object.hash(start, endExclusive);

  @override
  String toString() => 'DateRange($start – $endExclusive)';
}

enum PeriodType {
  quincena('Quincena'),
  month('Mes'),
  custom('Rango');

  const PeriodType(this.label);
  final String label;
}

/// Periodo seleccionado en los filtros: quincena, mes o rango personalizado.
@immutable
class PeriodSelection {
  const PeriodSelection._(this.type, this.range);

  factory PeriodSelection.quincena(DateTime anchor) {
    final q = Quincena.of(anchor);
    return PeriodSelection._(PeriodType.quincena, DateRange(q.start, q.endExclusive));
  }

  factory PeriodSelection.month(DateTime anchor) => PeriodSelection._(
    PeriodType.month,
    DateRange(DateTime(anchor.year, anchor.month), DateTime(anchor.year, anchor.month + 1)),
  );

  factory PeriodSelection.custom(DateRange range) => PeriodSelection._(PeriodType.custom, range);

  /// Cambia de tipo conservando la fecha de referencia.
  factory PeriodSelection.ofType(PeriodType type, DateTime anchor) => switch (type) {
    PeriodType.quincena => PeriodSelection.quincena(anchor),
    PeriodType.month => PeriodSelection.month(anchor),
    PeriodType.custom => PeriodSelection.custom(DateRange.days(anchor, anchor)),
  };

  final PeriodType type;
  final DateRange range;

  bool get canStep => type != PeriodType.custom;

  PeriodSelection get next => switch (type) {
    PeriodType.quincena => PeriodSelection.quincena(range.endExclusive),
    PeriodType.month => PeriodSelection.month(range.endExclusive),
    PeriodType.custom => this,
  };

  PeriodSelection get previous => switch (type) {
    PeriodType.quincena => PeriodSelection.quincena(range.start.subtract(const Duration(days: 1))),
    PeriodType.month => PeriodSelection.month(range.start.subtract(const Duration(days: 1))),
    PeriodType.custom => this,
  };

  /// `1 – 15 oct 2026`, `octubre 2026` o `3 sep – 10 oct 2026`.
  String get label {
    String short(DateTime d) => DateFormat('d MMM', 'es_MX').format(d).replaceAll('.', '');
    final last = range.lastDay;
    switch (type) {
      case PeriodType.quincena:
        final q = Quincena.of(range.start);
        return '${q.label} ${range.start.year}';
      case PeriodType.month:
        final m = DateFormat('MMMM y', 'es_MX').format(range.start);
        return '${m[0].toUpperCase()}${m.substring(1)}';
      case PeriodType.custom:
        if (range.start == last) return '${short(last)} ${last.year}';
        final sameYear = range.start.year == last.year;
        final from = sameYear ? short(range.start) : '${short(range.start)} ${range.start.year}';
        return '$from – ${short(last)} ${last.year}';
    }
  }

  @override
  bool operator ==(Object other) => other is PeriodSelection && other.type == type && other.range == range;

  @override
  int get hashCode => Object.hash(type, range);
}
