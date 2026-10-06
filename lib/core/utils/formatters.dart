import 'package:intl/intl.dart';

/// Formateo de montos y fechas en es_MX. Los montos llegan siempre en
/// centavos (int) para evitar errores de redondeo con double.
abstract final class Formatters {
  static const locale = 'es_MX';

  static final _currency = NumberFormat.currency(locale: locale, symbol: r'$', decimalDigits: 2);
  static final _currencyNoCents = NumberFormat.currency(locale: locale, symbol: r'$', decimalDigits: 0);
  static final _compact = NumberFormat.compactCurrency(locale: locale, symbol: r'$', decimalDigits: 1);
  static final _percent = NumberFormat.percentPattern(locale);

  /// `$1,234.50`
  static String money(int cents) => _currency.format(cents / 100);

  /// `$1,235` (redondeado). Útil en ejes de gráficas y chips.
  static String moneyRounded(int cents) => _currencyNoCents.format((cents / 100).round());

  /// `$12.5 mil`
  static String moneyCompact(int cents) => _compact.format(cents / 100);

  /// `+$1,234.50` / `-$1,234.50`
  static String moneySigned(int cents) => cents > 0 ? '+${money(cents)}' : money(cents);

  /// Recibe una fracción (0.8) → `80 %`.
  static String percent(double fraction) => _percent.format(fraction);

  /// `5 oct 2026`
  static String date(DateTime d) => DateFormat('d MMM y', locale).format(d).replaceAll('.', '');

  /// `5 oct`
  static String dayMonth(DateTime d) => DateFormat('d MMM', locale).format(d).replaceAll('.', '');

  /// `lunes, 5 de octubre`
  static String longDate(DateTime d) => DateFormat("EEEE, d 'de' MMMM", locale).format(d);

  /// `octubre 2026`
  static String monthYear(DateTime d) => DateFormat('MMMM y', locale).format(d);
}
