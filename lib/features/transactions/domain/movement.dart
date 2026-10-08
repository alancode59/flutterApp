import 'package:freezed_annotation/freezed_annotation.dart';

part 'movement.freezed.dart';

/// Los nombres de estos enums se guardan en la base de datos: no renombrarlos.
enum MovementKind {
  expense('Gasto'),
  income('Ingreso');

  const MovementKind(this.label);
  final String label;
}

enum PaymentMethod {
  cash('Efectivo'),
  debit('Débito'),

  /// Siempre ligado a una tarjeta (`cardId`).
  credit('Crédito');

  const PaymentMethod(this.label);
  final String label;
}

/// Un ingreso o gasto. Los montos son siempre positivos y en centavos;
/// el signo lo da [kind].
@freezed
abstract class Movement with _$Movement {
  const factory Movement({
    /// 0 para movimientos que aún no se guardan.
    @Default(0) int id,
    required MovementKind kind,
    required int amountCents,
    required int categoryId,
    required DateTime date,
    String? note,
    PaymentMethod? paymentMethod,
    int? cardId,
    @Default(false) bool isUnexpected,
    String? incomeSource,
    int? recurringRuleId,

    /// Mensualidad de una compra a MSI (1 = primera).
    int? installmentPlanId,
    int? installmentNumber,
  }) = _Movement;

  const Movement._();

  bool get isExpense => kind == MovementKind.expense;

  bool get isInstallment => installmentPlanId != null;

  bool get isCredit => paymentMethod == PaymentMethod.credit && cardId != null;

  /// Monto con signo: negativo para gastos.
  int get signedCents => isExpense ? -amountCents : amountCents;
}
