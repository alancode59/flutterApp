import 'package:freezed_annotation/freezed_annotation.dart';

import 'billing_cycle.dart';

part 'installment_plan.freezed.dart';

/// Plazos disponibles para meses sin intereses.
const kMsiOptions = [3, 6, 9, 10, 12, 18, 24];

/// Compra a meses sin intereses. Cada mensualidad se registra como un gasto
/// en su mes, así el presupuesto solo cuenta una mensualidad por periodo.
@freezed
abstract class InstallmentPlan with _$InstallmentPlan {
  const factory InstallmentPlan({
    @Default(0) int id,
    required int cardId,
    required String description,
    required int totalCents,
    required int months,
    required int categoryId,
    required DateTime purchaseDate,
  }) = _InstallmentPlan;

  const InstallmentPlan._();

  int get monthlyCents => totalCents ~/ months;

  /// Montos de cada mensualidad. El residuo de centavos va en la primera,
  /// para que la suma sea exactamente [totalCents].
  List<int> get installmentAmounts {
    final base = totalCents ~/ months;
    final remainder = totalCents - base * months;
    return [for (var i = 0; i < months; i++) i == 0 ? base + remainder : base];
  }

  /// Fecha de cada mensualidad: el mismo día de la compra en los meses siguientes.
  List<DateTime> get installmentDates => [
    for (var i = 0; i < months; i++)
      () {
        final day = BillingCycle.dayIn(purchaseDate.year, purchaseDate.month + i, purchaseDate.day);
        return DateTime(day.year, day.month, day.day, purchaseDate.hour, purchaseDate.minute);
      }(),
  ];

  /// Mensualidades cuya fecha ya llegó (incluido [today]).
  int billedCount(DateTime today) {
    final end = DateTime(today.year, today.month, today.day + 1);
    return installmentDates.where((d) => d.isBefore(end)).length;
  }

  /// Lo que falta por cargar después de [today].
  int remainingCents(DateTime today) {
    final billed = billedCount(today);
    return installmentAmounts.skip(billed).fold(0, (a, b) => a + b);
  }
}
