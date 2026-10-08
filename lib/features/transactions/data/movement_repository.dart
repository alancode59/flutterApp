import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../domain/movement.dart';
import '../domain/period.dart';

part 'movement_repository.g.dart';

class MovementRepository {
  MovementRepository(this._db);

  final AppDatabase _db;

  $MovementsTable get _t => _db.movements;

  static Movement toDomain(MovementRow r) => Movement(
    id: r.id,
    kind: r.kind,
    amountCents: r.amount,
    categoryId: r.categoryId,
    date: r.date,
    note: r.note,
    paymentMethod: r.paymentMethod,
    cardId: r.cardId,
    isUnexpected: r.isUnexpected,
    incomeSource: r.incomeSource,
    recurringRuleId: r.recurringRuleId,
    installmentPlanId: r.installmentPlanId,
    installmentNumber: r.installmentNumber,
  );

  static MovementsCompanion toCompanion(Movement m, {bool withId = false}) {
    final note = m.note?.trim();
    final source = m.incomeSource?.trim();
    final onCard = m.isExpense && m.paymentMethod == PaymentMethod.credit;
    return MovementsCompanion(
      id: withId ? Value(m.id) : const Value.absent(),
      kind: Value(m.kind),
      amount: Value(m.amountCents),
      categoryId: Value(m.categoryId),
      date: Value(m.date),
      note: Value(note == null || note.isEmpty ? null : note),
      paymentMethod: Value(m.isExpense ? m.paymentMethod : null),
      cardId: Value(onCard ? m.cardId : null),
      isUnexpected: Value(m.isExpense && m.isUnexpected),
      incomeSource: Value(m.isExpense || source == null || source.isEmpty ? null : source),
      recurringRuleId: Value(m.recurringRuleId),
      installmentPlanId: Value(m.installmentPlanId),
      installmentNumber: Value(m.installmentPlanId == null ? null : m.installmentNumber),
    );
  }

  List<OrderingTerm Function($MovementsTable)> get _newestFirst => [
    (m) => OrderingTerm.desc(m.date),
    (m) => OrderingTerm.desc(m.id),
  ];

  Stream<List<Movement>> watchRange(DateRange range) =>
      (_db.select(_t)
            ..where(
              (m) => m.date.isBiggerOrEqualValue(range.start) & m.date.isSmallerThanValue(range.endExclusive),
            )
            ..orderBy(_newestFirst))
          .watch()
          .map((rows) => rows.map(toDomain).toList());

  /// Los últimos movimientos hasta hoy (sin mensualidades MSI futuras).
  Stream<List<Movement>> watchRecent({int limit = 5, DateTime? now}) {
    final n = now ?? DateTime.now();
    final tomorrow = DateTime(n.year, n.month, n.day + 1);
    return (_db.select(_t)
          ..where((m) => m.date.isSmallerThanValue(tomorrow))
          ..orderBy(_newestFirst)
          ..limit(limit))
        .watch()
        .map((rows) => rows.map(toDomain).toList());
  }

  Future<int> add(Movement m) => _db.into(_t).insert(toCompanion(m));

  Future<void> update(Movement m) => (_db.update(_t)..where((t) => t.id.equals(m.id))).write(toCompanion(m));

  /// Borra y devuelve el movimiento para poder deshacer con [restore].
  Future<Movement?> delete(int id) => _db.transaction(() async {
    final row = await (_db.select(_t)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    await (_db.delete(_t)..where((t) => t.id.equals(id))).go();
    return toDomain(row);
  });

  /// Vuelve a insertar un movimiento borrado conservando su id.
  Future<void> restore(Movement m) => _db.into(_t).insertOnConflictUpdate(toCompanion(m, withId: true));

  /// Método de pago (y tarjeta) del último gasto capturado a mano.
  Future<({PaymentMethod method, int? cardId})?> lastPayment() async {
    final row =
        await (_db.select(_t)
              ..where(
                (m) =>
                    m.paymentMethod.isNotNull() & m.recurringRuleId.isNull() & m.installmentPlanId.isNull(),
              )
              ..orderBy([(m) => OrderingTerm.desc(m.createdAt), (m) => OrderingTerm.desc(m.id)])
              ..limit(1))
            .getSingleOrNull();
    if (row == null) return null;
    return (method: row.paymentMethod!, cardId: row.cardId);
  }

  /// Fuentes de ingreso usadas antes, las más recientes primero.
  Future<List<String>> incomeSources({int limit = 8}) async {
    final rows =
        await (_db.select(_t)
              ..where((m) => m.incomeSource.isNotNull())
              ..orderBy(_newestFirst))
            .get();
    final seen = <String>{};
    for (final r in rows) {
      seen.add(r.incomeSource!);
      if (seen.length >= limit) break;
    }
    return seen.toList();
  }
}

@Riverpod(keepAlive: true)
MovementRepository movementRepository(Ref ref) => MovementRepository(ref.watch(appDatabaseProvider));
