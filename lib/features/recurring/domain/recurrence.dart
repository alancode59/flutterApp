import 'recurring_rule.dart';

/// Cálculo de fechas de una regla recurrente. Todo trabaja con días
/// calendario (sin hora) para no depender de horarios de verano.
abstract final class Recurrence {
  /// Ocurrencias entre [from] y [to] (ambos incluidos), respetando
  /// [start] y [end] de la regla.
  static List<DateTime> occurrences({
    required Frequency frequency,
    required DateTime start,
    DateTime? end,
    required DateTime from,
    required DateTime to,
  }) {
    final s = _day(start);
    var lo = _day(from);
    if (lo.isBefore(s)) lo = s;
    var hi = _day(to);
    if (end != null && _day(end).isBefore(hi)) hi = _day(end);
    if (hi.isBefore(lo)) return const [];

    final result = <DateTime>[];
    void addIfInRange(DateTime d) {
      if (!d.isBefore(lo) && !d.isAfter(hi)) result.add(d);
    }

    switch (frequency) {
      case Frequency.weekly:
        final offset = _daysBetween(s, lo);
        var k = (offset / 7).ceil();
        while (true) {
          final d = DateTime(s.year, s.month, s.day + 7 * k);
          if (d.isAfter(hi)) break;
          addIfInRange(d);
          k++;
        }
      case Frequency.biweekly:
        for (var m = DateTime(lo.year, lo.month); !m.isAfter(hi); m = DateTime(m.year, m.month + 1)) {
          addIfInRange(DateTime(m.year, m.month, 15));
          addIfInRange(DateTime(m.year, m.month, _daysInMonth(m.year, m.month)));
        }
      case Frequency.monthly:
        for (var m = DateTime(lo.year, lo.month); !m.isAfter(hi); m = DateTime(m.year, m.month + 1)) {
          final day = s.day.clamp(1, _daysInMonth(m.year, m.month));
          addIfInRange(DateTime(m.year, m.month, day));
        }
      case Frequency.yearly:
        for (var y = lo.year; y <= hi.year; y++) {
          final day = s.day.clamp(1, _daysInMonth(y, s.month));
          addIfInRange(DateTime(y, s.month, day));
        }
    }
    return result;
  }

  /// Fechas pendientes de generar para [rule] hasta [today], incluido.
  static List<DateTime> dueDates(RecurringRule rule, DateTime today) {
    if (!rule.active) return const [];
    final last = rule.lastGeneratedDate;
    final from = last == null ? rule.startDate : _day(last).add(const Duration(days: 1));
    return occurrences(
      frequency: rule.frequency,
      start: rule.startDate,
      end: rule.endDate,
      from: from,
      to: today,
    );
  }

  /// Siguiente fecha que aún no se ha generado, o null si la regla terminó.
  static DateTime? nextDue(RecurringRule rule) {
    final last = rule.lastGeneratedDate;
    final from = last == null ? _day(rule.startDate) : _day(last).add(const Duration(days: 1));
    final upcoming = occurrences(
      frequency: rule.frequency,
      start: rule.startDate,
      end: rule.endDate,
      from: from,
      to: DateTime(from.year + 1, from.month, from.day + 1),
    );
    return upcoming.isEmpty ? null : upcoming.first;
  }

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  static int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

  static int _daysBetween(DateTime a, DateTime b) =>
      DateTime.utc(b.year, b.month, b.day).difference(DateTime.utc(a.year, a.month, a.day)).inDays;
}
