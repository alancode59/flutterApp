import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../transactions/domain/movement.dart';
import '../domain/recurrence.dart';
import '../domain/recurring_rule.dart';

part 'recurring_repository.g.dart';

class RecurringRepository {
  RecurringRepository(this._db);

  final AppDatabase _db;

  $RecurringRulesTable get _t => _db.recurringRules;

  static RecurringRule toDomain(RecurringRuleRow r) => RecurringRule(
    id: r.id,
    kind: r.kind,
    name: r.name,
    amountCents: r.amount,
    categoryId: r.categoryId,
    frequency: r.frequency,
    startDate: r.startDate,
    endDate: r.endDate,
    paymentMethod: r.paymentMethod,
    cardId: r.cardId,
    incomeSource: r.incomeSource,
    lastGeneratedDate: r.lastGeneratedDate,
    active: r.active,
  );

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  RecurringRulesCompanion _toCompanion(RecurringRule r) {
    final source = r.incomeSource?.trim();
    final isExpense = r.kind == MovementKind.expense;
    return RecurringRulesCompanion(
      kind: Value(r.kind),
      name: Value(r.name.trim()),
      amount: Value(r.amountCents),
      categoryId: Value(r.categoryId),
      frequency: Value(r.frequency),
      startDate: Value(_day(r.startDate)),
      endDate: Value(r.endDate == null ? null : _day(r.endDate!)),
      paymentMethod: Value(isExpense ? r.paymentMethod : null),
      cardId: Value(isExpense ? r.cardId : null),
      incomeSource: Value(isExpense || source == null || source.isEmpty ? null : source),
      active: Value(r.active),
    );
  }

  Stream<List<RecurringRule>> watchAll() =>
      (_db.select(_t)..orderBy([(r) => OrderingTerm.desc(r.active), (r) => OrderingTerm(expression: r.name)]))
          .watch()
          .map((rows) => rows.map(toDomain).toList());

  Future<int> add(RecurringRule r) => _db.into(_t).insert(_toCompanion(r));

  /// Editar no regenera lo ya registrado: los cambios aplican a las siguientes fechas.
  Future<void> update(RecurringRule r) =>
      (_db.update(_t)..where((t) => t.id.equals(r.id))).write(_toCompanion(r));

  /// Al reactivar no se registra lo que correspondía mientras estuvo en pausa.
  Future<void> setActive(int id, bool active, {DateTime? now}) => _db.transaction(() async {
    var companion = RecurringRulesCompanion(active: Value(active));
    if (active) {
      final row = await (_db.select(_t)..where((t) => t.id.equals(id))).getSingle();
      final yesterday = _day(now ?? DateTime.now()).subtract(const Duration(days: 1));
      final last = row.lastGeneratedDate;
      if (!row.startDate.isAfter(yesterday) && (last == null || last.isBefore(yesterday))) {
        companion = companion.copyWith(lastGeneratedDate: Value(yesterday));
      }
    }
    await (_db.update(_t)..where((t) => t.id.equals(id))).write(companion);
  });

  /// Los movimientos ya generados se conservan (pierden el vínculo con la regla).
  Future<void> delete(int id) => (_db.delete(_t)..where((t) => t.id.equals(id))).go();

  /// Registra los movimientos pendientes de todas las reglas activas hasta [now].
  /// Es seguro llamarlo varias veces: nunca duplica un movimiento.
  Future<int> generateDue(DateTime now) => _db.transaction(() async {
    final today = _day(now);
    final rules = await (_db.select(_t)..where((r) => r.active.equals(true))).get();
    var created = 0;

    for (final row in rules) {
      final rule = toDomain(row);
      if (_day(rule.startDate).isAfter(today)) continue;

      for (final date in Recurrence.dueDates(rule, today)) {
        final inserted = await _db
            .into(_db.movements)
            .insertReturningOrNull(
              MovementsCompanion.insert(
                kind: rule.kind,
                amount: rule.amountCents,
                categoryId: rule.categoryId,
                date: date,
                note: Value(rule.name),
                paymentMethod: Value(rule.paymentMethod),
                cardId: Value(rule.cardId),
                incomeSource: Value(rule.incomeSource),
                recurringRuleId: Value(rule.id),
              ),
              mode: InsertMode.insertOrIgnore,
            );
        if (inserted != null) created++;
      }
      await (_db.update(
        _t,
      )..where((t) => t.id.equals(rule.id))).write(RecurringRulesCompanion(lastGeneratedDate: Value(today)));
    }
    return created;
  });
}

@Riverpod(keepAlive: true)
RecurringRepository recurringRepository(Ref ref) => RecurringRepository(ref.watch(appDatabaseProvider));
