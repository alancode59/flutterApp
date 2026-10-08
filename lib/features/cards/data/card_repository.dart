import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../transactions/data/movement_repository.dart';
import '../../transactions/domain/movement.dart';
import '../domain/card_payment.dart';
import '../domain/credit_card.dart';
import '../domain/installment_plan.dart';

part 'card_repository.g.dart';

/// Resultado de quitar una tarjeta.
enum CardRemoval { deleted, archived }

/// Copia de una compra a MSI borrada, para poder deshacer.
@immutable
class DeletedPlan {
  const DeletedPlan(this.plan, this.installments);

  final InstallmentPlan plan;
  final List<Movement> installments;
}

class CardRepository {
  CardRepository(this._db);

  final AppDatabase _db;

  $CreditCardsTable get _cards => _db.creditCards;
  $CardPaymentsTable get _payments => _db.cardPayments;
  $InstallmentPlansTable get _plans => _db.installmentPlans;

  // ---------- Tarjetas ----------

  static CreditCard toDomain(CreditCardRow r) => CreditCard(
    id: r.id,
    name: r.name,
    bank: r.bank,
    last4: r.last4,
    network: r.network,
    colorIndex: r.colorIndex,
    limitCents: r.creditLimit,
    cutoffDay: r.cutoffDay,
    dueDay: r.dueDay,
    openingBalanceCents: r.openingBalance,
    balanceDate: r.balanceDate,
    statementRemainingCents: r.statementRemaining,
    minimumPaymentCents: r.minimumPayment,
    createdAt: r.createdAt,
    archived: r.archived,
  );

  CreditCardsCompanion _toCompanion(CreditCard c) {
    String? clean(String? v) => v == null || v.trim().isEmpty ? null : v.trim();
    return CreditCardsCompanion(
      name: Value(c.name.trim()),
      bank: Value(clean(c.bank)),
      last4: Value(clean(c.last4)),
      network: Value(c.network),
      colorIndex: Value(c.colorIndex),
      creditLimit: Value(c.limitCents),
      cutoffDay: Value(c.cutoffDay),
      dueDay: Value(c.dueDay),
      openingBalance: Value(c.openingBalanceCents),
      balanceDate: Value(c.balanceDate),
      statementRemaining: Value(c.statementRemainingCents),
      minimumPayment: Value(c.minimumPaymentCents),
      archived: Value(c.archived),
      createdAt: Value(c.createdAt),
    );
  }

  /// Todas las tarjetas, incluidas las archivadas, en el orden en que se agregaron.
  Stream<List<CreditCard>> watchAll() =>
      (_db.select(_cards)
            ..orderBy([(c) => OrderingTerm(expression: c.sortOrder), (c) => OrderingTerm(expression: c.id)]))
          .watch()
          .map((rows) => rows.map(toDomain).toList());

  Future<int> add(CreditCard c) async {
    final maxOrder = _cards.sortOrder.max();
    final current = await (_db.selectOnly(
      _cards,
    )..addColumns([maxOrder])).map((r) => r.read(maxOrder)).getSingle();
    return _db.into(_cards).insert(_toCompanion(c).copyWith(sortOrder: Value((current ?? -1) + 1)));
  }

  Future<void> update(CreditCard c) =>
      (_db.update(_cards)..where((t) => t.id.equals(c.id))).write(_toCompanion(c));

  Future<void> setArchived(int id, {required bool archived}) => (_db.update(
    _cards,
  )..where((t) => t.id.equals(id))).write(CreditCardsCompanion(archived: Value(archived)));

  /// Una tarjeta con compras o pagos se archiva para no alterar el historial;
  /// si no tiene actividad, se borra.
  Future<CardRemoval> remove(int id) => _db.transaction(() async {
    final used =
        await (_db.select(_db.movements)
              ..where((m) => m.cardId.equals(id))
              ..limit(1))
            .getSingleOrNull() !=
        null;
    final paid =
        await (_db.select(_payments)
              ..where((p) => p.cardId.equals(id))
              ..limit(1))
            .getSingleOrNull() !=
        null;
    final hasPlans =
        await (_db.select(_plans)
              ..where((p) => p.cardId.equals(id))
              ..limit(1))
            .getSingleOrNull() !=
        null;
    if (used || paid || hasPlans) {
      await setArchived(id, archived: true);
      return CardRemoval.archived;
    }
    await (_db.delete(_cards)..where((t) => t.id.equals(id))).go();
    return CardRemoval.deleted;
  });

  // ---------- Cargos ----------

  /// Gastos con crédito de todas las tarjetas, incluidas las mensualidades futuras.
  Stream<List<Movement>> watchCharges() =>
      (_db.select(_db.movements)
            ..where((m) => m.paymentMethod.equalsValue(PaymentMethod.credit) & m.cardId.isNotNull())
            ..orderBy([(m) => OrderingTerm.desc(m.date), (m) => OrderingTerm.desc(m.id)]))
          .watch()
          .map((rows) => rows.map(MovementRepository.toDomain).toList());

  // ---------- Pagos ----------

  static CardPayment paymentToDomain(CardPaymentRow r) =>
      CardPayment(id: r.id, cardId: r.cardId, amountCents: r.amount, date: r.date, note: r.note);

  CardPaymentsCompanion _paymentCompanion(CardPayment p, {bool withId = false}) {
    final note = p.note?.trim();
    return CardPaymentsCompanion(
      id: withId ? Value(p.id) : const Value.absent(),
      cardId: Value(p.cardId),
      amount: Value(p.amountCents),
      date: Value(p.date),
      note: Value(note == null || note.isEmpty ? null : note),
    );
  }

  Stream<List<CardPayment>> watchPayments() =>
      (_db.select(_payments)..orderBy([(p) => OrderingTerm.desc(p.date), (p) => OrderingTerm.desc(p.id)]))
          .watch()
          .map((rows) => rows.map(paymentToDomain).toList());

  Future<int> addPayment(CardPayment p) => _db.into(_payments).insert(_paymentCompanion(p));

  Future<CardPayment?> deletePayment(int id) => _db.transaction(() async {
    final row = await (_db.select(_payments)..where((p) => p.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    await (_db.delete(_payments)..where((p) => p.id.equals(id))).go();
    return paymentToDomain(row);
  });

  Future<void> restorePayment(CardPayment p) =>
      _db.into(_payments).insertOnConflictUpdate(_paymentCompanion(p, withId: true));

  // ---------- Meses sin intereses ----------

  static InstallmentPlan planToDomain(InstallmentPlanRow r) => InstallmentPlan(
    id: r.id,
    cardId: r.cardId,
    description: r.description,
    totalCents: r.total,
    months: r.months,
    categoryId: r.categoryId,
    purchaseDate: r.purchaseDate,
  );

  Future<InstallmentPlan?> getPlan(int id) async {
    final row = await (_db.select(_plans)..where((p) => p.id.equals(id))).getSingleOrNull();
    return row == null ? null : planToDomain(row);
  }

  Stream<List<InstallmentPlan>> watchPlans() =>
      (_db.select(_plans)..orderBy([(p) => OrderingTerm.desc(p.purchaseDate)])).watch().map(
        (rows) => rows.map(planToDomain).toList(),
      );

  /// Registra la compra y una mensualidad por mes. Devuelve el id del plan.
  Future<int> addInstallmentPurchase(InstallmentPlan plan, {bool isUnexpected = false, String? note}) =>
      _db.transaction(() async {
        final planId = await _db
            .into(_plans)
            .insert(
              InstallmentPlansCompanion.insert(
                cardId: plan.cardId,
                description: plan.description.trim(),
                total: plan.totalCents,
                months: plan.months,
                categoryId: plan.categoryId,
                purchaseDate: plan.purchaseDate,
              ),
            );
        await _insertInstallments(plan.copyWith(id: planId), isUnexpected: isUnexpected);
        return planId;
      });

  Future<void> _insertInstallments(InstallmentPlan plan, {bool isUnexpected = false}) async {
    final amounts = plan.installmentAmounts;
    final dates = plan.installmentDates;
    await _db.batch((b) {
      b.insertAll(_db.movements, [
        for (var i = 0; i < plan.months; i++)
          MovementRepository.toCompanion(
            Movement(
              kind: MovementKind.expense,
              amountCents: amounts[i],
              categoryId: plan.categoryId,
              date: dates[i],
              note: plan.description,
              paymentMethod: PaymentMethod.credit,
              cardId: plan.cardId,
              isUnexpected: isUnexpected,
              installmentPlanId: plan.id,
              installmentNumber: i + 1,
            ),
          ),
      ]);
    });
  }

  /// Borra la compra con todas sus mensualidades.
  Future<DeletedPlan?> deletePlan(int id) => _db.transaction(() async {
    final row = await (_db.select(_plans)..where((p) => p.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    final installments = await (_db.select(
      _db.movements,
    )..where((m) => m.installmentPlanId.equals(id))).get();
    await (_db.delete(_plans)..where((p) => p.id.equals(id))).go();
    return DeletedPlan(planToDomain(row), installments.map(MovementRepository.toDomain).toList());
  });

  Future<void> restorePlan(DeletedPlan deleted) => _db.transaction(() async {
    final p = deleted.plan;
    await _db
        .into(_plans)
        .insertOnConflictUpdate(
          InstallmentPlansCompanion.insert(
            id: Value(p.id),
            cardId: p.cardId,
            description: p.description,
            total: p.totalCents,
            months: p.months,
            categoryId: p.categoryId,
            purchaseDate: p.purchaseDate,
          ),
        );
    await _db.batch((b) {
      b.insertAllOnConflictUpdate(_db.movements, [
        for (final m in deleted.installments) MovementRepository.toCompanion(m, withId: true),
      ]);
    });
  });
}

@Riverpod(keepAlive: true)
CardRepository cardRepository(Ref ref) => CardRepository(ref.watch(appDatabaseProvider));
