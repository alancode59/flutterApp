import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

/// Periodo quincenal de calendario: del 1 al 15 y del 16 al último día del mes.
///
/// [start] es inclusivo y [endExclusive] es el primer instante de la siguiente
/// quincena, para que las consultas por rango no pierdan movimientos a las 23:59.
@immutable
class Quincena {
  const Quincena._(this.start, this.endExclusive);

  factory Quincena.of(DateTime date) {
    final y = date.year;
    final m = date.month;
    return date.day <= 15
        ? Quincena._(DateTime(y, m, 1), DateTime(y, m, 16))
        : Quincena._(DateTime(y, m, 16), DateTime(y, m + 1, 1));
  }

  factory Quincena.current() => Quincena.of(DateTime.now());

  final DateTime start;
  final DateTime endExclusive;

  bool get isFirstHalf => start.day == 1;

  /// Último día calendario de la quincena (15, 28, 29, 30 o 31).
  DateTime get lastDay => endExclusive.subtract(const Duration(days: 1));

  int get lengthInDays => lastDay.day - start.day + 1;

  Quincena get next => Quincena.of(endExclusive);

  Quincena get previous => Quincena.of(start.subtract(const Duration(days: 1)));

  bool contains(DateTime d) => !d.isBefore(start) && d.isBefore(endExclusive);

  /// Días que faltan para terminar, contando [today]. Fuera del periodo es 0.
  int daysLeft(DateTime today) {
    if (!contains(today)) return 0;
    final t = DateTime(today.year, today.month, today.day);
    return lastDay.difference(t).inDays + 1;
  }

  /// `1 – 15 oct` o `16 – 31 oct`.
  String get label {
    final month = DateFormat('MMM', 'es_MX').format(start).replaceAll('.', '');
    return '${start.day} – ${lastDay.day} $month';
  }

  @override
  bool operator ==(Object other) => other is Quincena && other.start == start;

  @override
  int get hashCode => start.hashCode;

  @override
  String toString() => 'Quincena($label ${start.year})';
}
