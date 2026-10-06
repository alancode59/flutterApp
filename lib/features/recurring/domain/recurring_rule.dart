import 'package:freezed_annotation/freezed_annotation.dart';

import '../../transactions/domain/movement.dart';

part 'recurring_rule.freezed.dart';

/// Los nombres se guardan en la base de datos: no renombrarlos.
enum Frequency {
  weekly('Semanal', 'Cada semana'),
  biweekly('Quincenal', 'Días 15 y último de cada mes'),
  monthly('Mensual', 'Mismo día cada mes'),
  yearly('Anual', 'Misma fecha cada año');

  const Frequency(this.label, this.description);
  final String label;
  final String description;
}

/// Pago o ingreso que se registra solo cada periodo (renta, streaming, quincena…).
@freezed
abstract class RecurringRule with _$RecurringRule {
  const factory RecurringRule({
    @Default(0) int id,
    required MovementKind kind,
    required String name,
    required int amountCents,
    required int categoryId,
    required Frequency frequency,
    required DateTime startDate,
    DateTime? endDate,
    PaymentMethod? paymentMethod,
    int? cardId,
    String? incomeSource,

    /// Último día hasta el que ya se generaron movimientos.
    DateTime? lastGeneratedDate,
    @Default(true) bool active,
  }) = _RecurringRule;
}
