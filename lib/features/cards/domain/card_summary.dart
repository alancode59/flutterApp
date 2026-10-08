import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../../../core/utils/dates.dart';
import '../../transactions/domain/movement.dart';
import 'billing_cycle.dart';
import 'card_payment.dart';
import 'credit_card.dart';

/// Situación del pago del último corte.
enum PaymentStatus {
  /// El último corte no dejó saldo por pagar.
  none,

  /// Hay saldo y aún no vence.
  pending,

  /// Ya se cubrió el pago para no generar intereses.
  paid,

  /// Pasó la fecha límite y quedó saldo.
  overdue,
}

/// Pago mínimo aproximado según la regla de Banxico: el mayor entre 1.5 % del
/// saldo revolvente y 1.25 % de la línea de crédito, más las mensualidades MSI.
/// Los intereses e IVA no se conocen sin el estado de cuenta real.
int estimateMinimumPayment({required int statementCents, required int msiCents, required int limitCents}) {
  if (statementCents <= 0) return 0;
  final revolving = math.max(0, statementCents - msiCents);
  final base = math.max(revolving * 0.015, limitCents * 0.0125).round();
  return math.min(statementCents, base + msiCents);
}

/// Cálculos de una tarjeta a una fecha: corte proyectado, pago para no generar
/// intereses, pago mínimo y utilización. Es puro: recibe todos los cargos y
/// pagos de la tarjeta.
@immutable
class CardSummary {
  const CardSummary._({
    required this.card,
    required this.today,
    required this.currentCycle,
    required this.lastCycle,
    required this.statementCents,
    required this.statementMsiCents,
    required this.paidSinceStatementCents,
    required this.minimumCents,
    required this.minimumFromBank,
    required this.fromBank,
    required this.cyclePurchasesCents,
    required this.cycleInstallmentsCents,
    required this.usedCents,
    required this.msiPendingCents,
  });

  /// [charges] son los gastos con crédito de esta tarjeta (incluye las
  /// mensualidades MSI futuras); [payments], los pagos hechos a ella.
  /// [planPurchaseDates] da la fecha de compra de cada plan MSI, para saber si
  /// sus mensualidades ya estaban incluidas en el saldo del banco.
  ///
  /// Si la tarjeta tiene saldos copiados del banco en el periodo actual, el
  /// último corte (pago para no generar intereses y mínimo) sale de ellos; si
  /// ya pasó un corte desde entonces, se calcula con lo registrado después.
  factory CardSummary.compute({
    required CreditCard card,
    required List<Movement> charges,
    required List<CardPayment> payments,
    required DateTime now,
    Map<int, DateTime> planPurchaseDates = const {},
  }) {
    final today = DateTime(now.year, now.month, now.day);
    final current = card.cycleOf(today);
    final last = current.previous;

    // Lo anterior al saldo del banco ya está incluido en él.
    final asOf = card.balanceAsOf;
    bool counts(DateTime when) => when.isAfter(asOf) || when == asOf && card.balanceDate == null;
    final newCharges = charges.where((m) {
      final purchased = m.installmentPlanId == null
          ? m.date
          : planPurchaseDates[m.installmentPlanId] ?? m.date;
      return counts(purchased);
    });
    final newPayments = payments.where((p) => counts(p.date));

    final opening = card.openingBalanceCents;
    final fromBank =
        card.balanceDate != null && card.statementRemainingCents != null && !asOf.isBefore(current.start);

    var chargedUntilLast = 0;
    var lastMsi = 0;
    var cyclePurchases = 0;
    var cycleInstallments = 0;
    var allCharges = 0;
    var msiPending = 0;
    for (final m in newCharges) {
      allCharges += m.amountCents;
      final installment = m.installmentPlanId != null;
      if (m.date.isBefore(last.endExclusive)) {
        chargedUntilLast += m.amountCents;
        if (installment && last.contains(m.date)) lastMsi += m.amountCents;
      } else if (current.contains(m.date)) {
        if (installment) {
          cycleInstallments += m.amountCents;
        } else {
          cyclePurchases += m.amountCents;
        }
      } else if (installment) {
        msiPending += m.amountCents;
      }
    }

    var paidUntilLast = 0;
    var paidSince = 0;
    var paidAll = 0;
    for (final p in newPayments) {
      paidAll += p.amountCents;
      if (!fromBank && p.date.isBefore(last.endExclusive)) {
        paidUntilLast += p.amountCents;
      } else {
        paidSince += p.amountCents;
      }
    }

    final int statement;
    final int minimum;
    if (fromBank) {
      // Lo que el banco dice que falta del último corte; el resto de la deuda
      // son compras de este periodo (o MSI que el banco ya sumó).
      statement = card.statementRemainingCents!;
      cyclePurchases += math.max(0, opening - statement);
      minimum =
          card.minimumPaymentCents ??
          estimateMinimumPayment(statementCents: statement, msiCents: 0, limitCents: card.limitCents);
    } else {
      if (asOf.isBefore(last.endExclusive)) {
        chargedUntilLast += opening;
      } else {
        cyclePurchases += opening;
      }
      statement = chargedUntilLast - paidUntilLast;
      minimum = estimateMinimumPayment(
        statementCents: statement,
        msiCents: lastMsi,
        limitCents: card.limitCents,
      );
    }

    return CardSummary._(
      card: card,
      today: today,
      currentCycle: current,
      lastCycle: last,
      statementCents: statement,
      statementMsiCents: lastMsi,
      paidSinceStatementCents: paidSince,
      minimumCents: minimum,
      minimumFromBank: fromBank && card.minimumPaymentCents != null,
      fromBank: fromBank,
      cyclePurchasesCents: cyclePurchases,
      cycleInstallmentsCents: cycleInstallments,
      usedCents: math.max(0, opening + allCharges - paidAll),
      msiPendingCents: msiPending,
    );
  }

  final CreditCard card;
  final DateTime today;

  /// Periodo abierto: las compras de hoy caen aquí.
  final BillingCycle currentCycle;

  /// Último periodo cerrado: su saldo es el que se paga ahora.
  final BillingCycle lastCycle;

  // ---------- Último corte ----------

  /// Saldo al último corte. Negativo si quedó saldo a favor.
  final int statementCents;

  /// Mensualidades MSI incluidas en el último corte.
  final int statementMsiCents;

  /// Pagos hechos después del último corte.
  final int paidSinceStatementCents;

  /// Pago mínimo del último corte (sin restar pagos): el del banco o uno aproximado.
  final int minimumCents;

  /// El mínimo viene del banco y no es una estimación.
  final bool minimumFromBank;

  /// Los montos del último corte vienen de los saldos copiados del banco.
  final bool fromBank;

  /// Lo que falta pagar para no generar intereses.
  int get noInterestRemainingCents => math.max(0, statementCents - paidSinceStatementCents);

  int get minimumRemainingCents => math.max(0, minimumCents - paidSinceStatementCents);

  DateTime get dueDate => lastCycle.dueDate;

  PaymentStatus get status {
    if (statementCents <= 0) return PaymentStatus.none;
    if (noInterestRemainingCents == 0) return PaymentStatus.paid;
    if (today.isAfter(dueDate)) return PaymentStatus.overdue;
    return PaymentStatus.pending;
  }

  /// Fracción ya pagada del último corte (0–1).
  double get statementPaidFraction =>
      statementCents <= 0 ? 1 : (paidSinceStatementCents / statementCents).clamp(0.0, 1.0);

  // ---------- Periodo actual ----------

  /// Compras normales del periodo abierto.
  final int cyclePurchasesCents;

  /// Mensualidades MSI que caen en el periodo abierto.
  final int cycleInstallmentsCents;

  /// Saldo del corte anterior que sigue sin pagarse (negativo si hay saldo a favor).
  int get carriedCents => statementCents - paidSinceStatementCents;

  /// Monto aproximado del próximo corte si no se hacen más pagos.
  int get projectedStatementCents => math.max(0, carriedCents + cyclePurchasesCents + cycleInstallmentsCents);

  int get daysToCutoff => daysBetween(today, currentCycle.cutoff);

  // ---------- Línea de crédito ----------

  /// Crédito usado, incluido lo que falta de cada compra a MSI.
  final int usedCents;

  /// Mensualidades MSI de periodos futuros.
  final int msiPendingCents;

  int get limitCents => card.limitCents;

  int get availableCents => limitCents - usedCents;

  double get utilization => limitCents <= 0 ? 0 : usedCents / limitCents;

  // ---------- Próximo pago ----------

  /// Si el último corte ya quedó cubierto, lo siguiente es el corte en curso.
  bool get nextIsCurrentCycle => status == PaymentStatus.none || status == PaymentStatus.paid;

  DateTime get nextDueDate => nextIsCurrentCycle ? currentCycle.dueDate : dueDate;

  int get nextDueCents => nextIsCurrentCycle ? projectedStatementCents : noInterestRemainingCents;

  /// Días para la fecha límite (negativo si ya venció).
  int get daysToNextDue => daysBetween(today, nextDueDate);
}
