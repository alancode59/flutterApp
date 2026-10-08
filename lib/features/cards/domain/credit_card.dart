import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'billing_cycle.dart';
import 'card_style.dart';

part 'credit_card.freezed.dart';

/// Los nombres se guardan en la base de datos: no renombrarlos.
enum CardNetwork {
  visa('Visa'),
  mastercard('Mastercard'),
  amex('American Express'),
  other('Otra');

  const CardNetwork(this.label);
  final String label;
}

@freezed
abstract class CreditCard with _$CreditCard {
  const factory CreditCard({
    @Default(0) int id,

    /// Alias que eligió el usuario ("Oro", "La de los viajes"…).
    required String name,
    String? bank,

    /// Últimos 4 dígitos, solo para reconocerla. Nunca el número completo.
    String? last4,
    @Default(CardNetwork.visa) CardNetwork network,
    @Default(0) int colorIndex,
    required int limitCents,

    /// Día del mes del corte (1–31; en meses cortos se usa el último día).
    required int cutoffDay,

    /// Día del mes de la fecha límite de pago, posterior al corte.
    required int dueDay,

    /// Deuda total según el banco en [balanceDate] (incluye compras del
    /// periodo y MSI pendientes). Sin [balanceDate] es el saldo que ya debía
    /// al darla de alta y se considera parte del corte anterior a [createdAt].
    @Default(0) int openingBalanceCents,

    /// Cuándo se copiaron los saldos del banco. Las compras y pagos
    /// registrados antes de esta fecha ya están incluidos en ellos.
    DateTime? balanceDate,

    /// Pago para no generar intereses que faltaba en [balanceDate].
    int? statementRemainingCents,

    /// Pago mínimo que faltaba en [balanceDate]. Si no se da, se estima.
    int? minimumPaymentCents,
    required DateTime createdAt,
    @Default(false) bool archived,
  }) = _CreditCard;

  const CreditCard._();

  CardStyle get style => CardStyle.byIndex(colorIndex);

  Color get color => style.color;

  /// "BBVA •• 1234" o solo el alias.
  String get shortLabel {
    final digits = last4 == null || last4!.isEmpty ? '' : ' •• $last4';
    return '$name$digits';
  }

  BillingCycle cycleOf(DateTime date) => BillingCycle.containing(date, cutoffDay: cutoffDay, dueDay: dueDay);

  /// Momento a partir del cual cuentan las compras y pagos registrados: la
  /// última actualización con el banco o, si no hay, el corte previo al alta.
  DateTime get balanceAsOf => balanceDate ?? cycleOf(createdAt).previous.cutoff;
}
