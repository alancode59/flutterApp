import 'package:finanzas/features/cards/domain/card_payment.dart';
import 'package:finanzas/features/cards/domain/card_summary.dart';
import 'package:finanzas/features/cards/domain/credit_card.dart';
import 'package:finanzas/features/cards/domain/installment_plan.dart';
import 'package:finanzas/features/transactions/domain/movement.dart';
import 'package:flutter_test/flutter_test.dart';

/// Corte el 15, pago el 5. Dada de alta el 1 de septiembre.
CreditCard card({int opening = 0, int limit = 2000000, DateTime? createdAt}) => CreditCard(
  id: 1,
  name: 'Oro',
  limitCents: limit,
  cutoffDay: 15,
  dueDay: 5,
  openingBalanceCents: opening,
  createdAt: createdAt ?? DateTime(2026, 9, 1),
);

Movement buy(int cents, DateTime date, {int? planId}) => Movement(
  kind: MovementKind.expense,
  amountCents: cents,
  categoryId: 1,
  date: date,
  paymentMethod: PaymentMethod.credit,
  cardId: 1,
  installmentPlanId: planId,
);

CardPayment pay(int cents, DateTime date) => CardPayment(cardId: 1, amountCents: cents, date: date);

CardSummary summary({
  CreditCard? c,
  List<Movement> charges = const [],
  List<CardPayment> payments = const [],
  required DateTime now,
}) => CardSummary.compute(card: c ?? card(), charges: charges, payments: payments, now: now);

void main() {
  group('ciclos', () {
    test('hoy 7 oct: periodo actual 16 sep – 15 oct y último corte el 15 sep', () {
      final s = summary(now: DateTime(2026, 10, 7));
      expect(s.currentCycle.cutoff, DateTime(2026, 10, 15));
      expect(s.lastCycle.cutoff, DateTime(2026, 9, 15));
      expect(s.dueDate, DateTime(2026, 10, 5));
      expect(s.daysToCutoff, 8);
    });
  });

  group('corte proyectado', () {
    test('suma las compras del periodo abierto', () {
      final s = summary(
        now: DateTime(2026, 10, 7),
        charges: [buy(50000, DateTime(2026, 9, 20)), buy(25050, DateTime(2026, 10, 7, 9))],
      );
      expect(s.cyclePurchasesCents, 75050);
      expect(s.projectedStatementCents, 75050);
      expect(s.statementCents, 0);
    });

    test('incluye el saldo anterior que no se ha pagado', () {
      final s = summary(
        now: DateTime(2026, 10, 7),
        charges: [buy(100000, DateTime(2026, 9, 10)), buy(20000, DateTime(2026, 10, 1))],
        payments: [pay(30000, DateTime(2026, 9, 25))],
      );
      expect(s.statementCents, 100000);
      expect(s.carriedCents, 70000);
      expect(s.projectedStatementCents, 90000);
    });

    test('un pago mayor al corte deja saldo a favor que reduce el siguiente', () {
      final s = summary(
        now: DateTime(2026, 10, 7),
        charges: [buy(100000, DateTime(2026, 9, 10)), buy(20000, DateTime(2026, 10, 1))],
        payments: [pay(110000, DateTime(2026, 9, 25))],
      );
      expect(s.carriedCents, -10000);
      expect(s.projectedStatementCents, 10000);
    });

    test('la compra del día de corte entra en ese corte', () {
      final s = summary(now: DateTime(2026, 10, 15, 20), charges: [buy(1000, DateTime(2026, 10, 15, 19))]);
      expect(s.cyclePurchasesCents, 1000);
      final next = summary(now: DateTime(2026, 10, 16), charges: [buy(1000, DateTime(2026, 10, 15, 19))]);
      expect(next.cyclePurchasesCents, 0);
      expect(next.statementCents, 1000);
    });
  });

  group('pago para no generar intereses', () {
    test('es el saldo al corte menos lo pagado después', () {
      final s = summary(
        now: DateTime(2026, 9, 25),
        charges: [buy(80000, DateTime(2026, 9, 1))],
        payments: [pay(30000, DateTime(2026, 9, 20))],
      );
      expect(s.statementCents, 80000);
      expect(s.noInterestRemainingCents, 50000);
      expect(s.status, PaymentStatus.pending);
      expect(s.statementPaidFraction, closeTo(0.375, 0.001));
    });

    test('pagado por completo', () {
      final s = summary(
        now: DateTime(2026, 9, 25),
        charges: [buy(80000, DateTime(2026, 9, 1))],
        payments: [pay(80000, DateTime(2026, 9, 20))],
      );
      expect(s.noInterestRemainingCents, 0);
      expect(s.status, PaymentStatus.paid);
      expect(s.nextIsCurrentCycle, isTrue);
    });

    test('vencido si pasa la fecha límite con saldo', () {
      final s = summary(now: DateTime(2026, 10, 6), charges: [buy(80000, DateTime(2026, 9, 1))]);
      expect(s.status, PaymentStatus.overdue);
      expect(s.daysToNextDue, -1);
    });

    test('los pagos anteriores al corte ya están descontados del saldo', () {
      final s = summary(
        now: DateTime(2026, 9, 25),
        charges: [buy(80000, DateTime(2026, 9, 1))],
        payments: [pay(20000, DateTime(2026, 9, 10))],
      );
      expect(s.statementCents, 60000);
      expect(s.noInterestRemainingCents, 60000);
    });

    test('sin saldo en el corte no hay nada que pagar', () {
      final s = summary(now: DateTime(2026, 9, 25));
      expect(s.status, PaymentStatus.none);
      expect(s.minimumCents, 0);
    });
  });

  group('saldo inicial', () {
    test('cuenta en el último corte antes del alta', () {
      final c = card(opening: 500000, createdAt: DateTime(2026, 10, 2));
      expect(c.balanceAsOf, DateTime(2026, 9, 15));
      final s = summary(c: c, now: DateTime(2026, 10, 2));
      expect(s.statementCents, 500000);
      expect(s.noInterestRemainingCents, 500000);
      expect(s.dueDate, DateTime(2026, 10, 5));
      expect(s.usedCents, 500000);
    });
  });

  group('pago mínimo', () {
    test('1.5 % del saldo si es mayor que 1.25 % de la línea', () {
      expect(estimateMinimumPayment(statementCents: 2000000, msiCents: 0, limitCents: 2000000), 30000);
    });

    test('1.25 % de la línea si es mayor', () {
      expect(estimateMinimumPayment(statementCents: 100000, msiCents: 0, limitCents: 4000000), 50000);
    });

    test('suma las mensualidades MSI del corte', () {
      expect(estimateMinimumPayment(statementCents: 300000, msiCents: 100000, limitCents: 1000000), 112500);
    });

    test('nunca supera el saldo', () {
      expect(estimateMinimumPayment(statementCents: 10000, msiCents: 0, limitCents: 4000000), 10000);
    });

    test('se descuenta lo ya pagado', () {
      final s = summary(
        now: DateTime(2026, 9, 25),
        charges: [buy(2000000, DateTime(2026, 9, 1))],
        payments: [pay(10000, DateTime(2026, 9, 20))],
      );
      expect(s.minimumCents, 30000);
      expect(s.minimumRemainingCents, 20000);
    });
  });

  group('MSI', () {
    final plan = InstallmentPlan(
      cardId: 1,
      description: 'Pantalla',
      totalCents: 1200001,
      months: 12,
      categoryId: 1,
      purchaseDate: DateTime(2026, 9, 20, 14),
    );

    test('reparte el total y el residuo va en la primera', () {
      final amounts = plan.installmentAmounts;
      expect(amounts.length, 12);
      expect(amounts.first, 100001);
      expect(amounts.skip(1).every((a) => a == 100000), isTrue);
      expect(amounts.fold(0, (a, b) => a + b), 1200001);
    });

    test('una mensualidad por mes, mismo día', () {
      final dates = plan.installmentDates;
      expect(dates[0], DateTime(2026, 9, 20, 14));
      expect(dates[1], DateTime(2026, 10, 20, 14));
      expect(dates[11], DateTime(2027, 8, 20, 14));
    });

    test('compra del día 31 se ajusta en meses cortos', () {
      final p = plan.copyWith(purchaseDate: DateTime(2026, 1, 31), months: 3);
      expect(p.installmentDates, [DateTime(2026, 1, 31), DateTime(2026, 2, 28), DateTime(2026, 3, 31)]);
    });

    test('mensualidades cargadas y lo que falta', () {
      expect(plan.billedCount(DateTime(2026, 10, 20)), 2);
      expect(plan.remainingCents(DateTime(2026, 10, 20)), 1000000);
    });

    test('el corte solo cuenta la mensualidad; la línea, todo lo pendiente', () {
      final installments = [
        for (final (i, d) in plan.installmentDates.indexed) buy(plan.installmentAmounts[i], d, planId: 7),
      ];
      final s = summary(now: DateTime(2026, 10, 7), charges: installments);
      expect(s.cycleInstallmentsCents, 100001);
      expect(s.projectedStatementCents, 100001);
      expect(s.msiPendingCents, 1100000);
      expect(s.usedCents, 1200001);
      expect(s.availableCents, 2000000 - 1200001);
    });

    test('las mensualidades del último corte suben el pago mínimo', () {
      final s = summary(
        now: DateTime(2026, 10, 20),
        charges: [buy(100000, DateTime(2026, 10, 10), planId: 7), buy(200000, DateTime(2026, 10, 1))],
      );
      expect(s.statementMsiCents, 100000);
      expect(s.minimumCents, 25000 + 100000);
    });
  });

  group('utilización', () {
    test('usado y disponible', () {
      final s = summary(
        c: card(limit: 1000000),
        now: DateTime(2026, 10, 7),
        charges: [buy(400000, DateTime(2026, 9, 1)), buy(100000, DateTime(2026, 10, 1))],
        payments: [pay(200000, DateTime(2026, 9, 30))],
      );
      expect(s.usedCents, 300000);
      expect(s.availableCents, 700000);
      expect(s.utilization, closeTo(0.3, 0.0001));
    });

    test('sin límite la utilización es 0', () {
      final s = summary(
        c: card(limit: 0),
        now: DateTime(2026, 10, 7),
        charges: [buy(1, DateTime(2026, 10, 1))],
      );
      expect(s.utilization, 0);
    });
  });

  group('próximo pago', () {
    test('pendiente: el del último corte', () {
      final s = summary(now: DateTime(2026, 9, 25), charges: [buy(80000, DateTime(2026, 9, 1))]);
      expect(s.nextDueDate, DateTime(2026, 10, 5));
      expect(s.nextDueCents, 80000);
      expect(s.daysToNextDue, 10);
    });

    test('sin saldo pendiente: el proyectado del corte en curso', () {
      final s = summary(now: DateTime(2026, 9, 25), charges: [buy(30000, DateTime(2026, 9, 20))]);
      expect(s.nextDueDate, DateTime(2026, 11, 5));
      expect(s.nextDueCents, 30000);
    });
  });

  group('saldos copiados del banco (tarjeta Azul)', () {
    // Límite $13,700, corte día 4, pago día 26. Datos de la app del banco el 7 oct.
    final azul = CreditCard(
      id: 1,
      name: 'Azul',
      limitCents: 1370000,
      cutoffDay: 4,
      dueDay: 26,
      openingBalanceCents: 704048,
      balanceDate: DateTime(2026, 10, 7, 10),
      statementRemainingCents: 347622,
      minimumPaymentCents: 52000,
      createdAt: DateTime(2026, 10, 7, 10),
    );

    test('muestra lo que dice el banco', () {
      final s = summary(c: azul, now: DateTime(2026, 10, 7, 12));
      expect(s.fromBank, isTrue);
      expect(s.noInterestRemainingCents, 347622);
      expect(s.dueDate, DateTime(2026, 10, 26));
      expect(s.minimumRemainingCents, 52000);
      expect(s.minimumFromBank, isTrue);
      expect(s.usedCents, 704048);
      expect(s.availableCents, 665952);
      expect(s.status, PaymentStatus.pending);
      // Lo que no es del corte anterior son compras de este periodo.
      expect(s.cyclePurchasesCents, 356426);
      expect(s.projectedStatementCents, 704048);
    });

    test('lo registrado antes de copiar los saldos no se cuenta dos veces', () {
      final s = summary(
        c: azul,
        now: DateTime(2026, 10, 8),
        charges: [buy(50000, DateTime(2026, 10, 6)), buy(10000, DateTime(2026, 10, 7, 18))],
        payments: [pay(100000, DateTime(2026, 10, 5))],
      );
      expect(s.usedCents, 714048);
      expect(s.noInterestRemainingCents, 347622);
    });

    test('pagos y compras posteriores actualizan todo', () {
      final s = summary(
        c: azul,
        now: DateTime(2026, 10, 20),
        charges: [buy(20000, DateTime(2026, 10, 10))],
        payments: [pay(100000, DateTime(2026, 10, 15))],
      );
      expect(s.noInterestRemainingCents, 247622);
      expect(s.minimumRemainingCents, 0);
      expect(s.usedCents, 624048);
      expect(s.availableCents, 745952);
      expect(s.projectedStatementCents, 624048);
    });

    test('al pagar todo el corte queda al corriente', () {
      final s = summary(
        c: azul,
        now: DateTime(2026, 10, 20),
        payments: [pay(347622, DateTime(2026, 10, 18))],
      );
      expect(s.status, PaymentStatus.paid);
      expect(s.nextDueDate, DateTime(2026, 11, 26));
      expect(s.nextDueCents, 356426);
    });

    test('compras MSI hechas antes de copiar los saldos no se suman', () {
      final s = summary(
        c: azul,
        now: DateTime(2026, 10, 8),
        charges: [
          buy(10000, DateTime(2026, 11, 1), planId: 3),
          buy(10000, DateTime(2026, 11, 20), planId: 4),
        ],
      );
      final withDates = CardSummary.compute(
        card: azul,
        charges: [
          buy(10000, DateTime(2026, 11, 1), planId: 3),
          buy(10000, DateTime(2026, 11, 20), planId: 4),
        ],
        payments: const [],
        now: DateTime(2026, 10, 8),
        planPurchaseDates: {3: DateTime(2026, 10, 1), 4: DateTime(2026, 10, 8)},
      );
      expect(s.usedCents, 724048);
      expect(withDates.usedCents, 714048);
    });

    test('después del siguiente corte, se calcula con lo registrado', () {
      final s = summary(
        c: azul,
        now: DateTime(2026, 11, 6),
        charges: [buy(30000, DateTime(2026, 10, 20))],
        payments: [pay(347622, DateTime(2026, 10, 25))],
      );
      expect(s.fromBank, isFalse);
      expect(s.lastCycle.cutoff, DateTime(2026, 11, 4));
      expect(s.statementCents, 704048 + 30000 - 347622);
      expect(s.dueDate, DateTime(2026, 11, 26));
      expect(s.minimumFromBank, isFalse);
    });

    test('sin pago mínimo del banco, se estima', () {
      final s = summary(c: azul.copyWith(minimumPaymentCents: null), now: DateTime(2026, 10, 8));
      expect(s.minimumFromBank, isFalse);
      expect(s.minimumCents, 17125); // 1.25 % de la línea
    });
  });
}
