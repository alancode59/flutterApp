import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../transactions/domain/movement.dart';
import '../domain/category.dart';

part 'category_repository.g.dart';

class CategoryRepository {
  CategoryRepository(this._db);

  final AppDatabase _db;

  $CategoriesTable get _t => _db.categories;

  static Category toDomain(CategoryRow r) => Category(
    id: r.id,
    name: r.name,
    iconKey: r.icon,
    colorValue: r.color,
    kind: r.kind,
    sortOrder: r.sortOrder,
    archived: r.archived,
  );

  /// Todas las categorías, incluidas las archivadas (para pintar el historial).
  Stream<List<Category>> watchAll() =>
      (_db.select(
            _t,
          )..orderBy([(c) => OrderingTerm(expression: c.sortOrder), (c) => OrderingTerm(expression: c.name)]))
          .watch()
          .map((rows) => rows.map(toDomain).toList());

  /// Categorías activas de un tipo, las más usadas en los últimos 90 días primero.
  Stream<List<Category>> watchByUsage(MovementKind kind, {DateTime? now}) {
    final since = (now ?? DateTime.now()).subtract(const Duration(days: 90));
    return _db
        .customSelect(
          'SELECT c.*, (SELECT COUNT(*) FROM movements m '
          'WHERE m.category_id = c.id AND m.date >= ?1) AS uses '
          'FROM categories c WHERE c.archived = 0 AND c.kind = ?2 '
          'ORDER BY uses DESC, c.sort_order, c.name',
          variables: [Variable<DateTime>(since), Variable<String>(kind.name)],
          readsFrom: {_t, _db.movements},
        )
        .watch()
        .map((rows) => rows.map((r) => toDomain(_t.map(r.data))).toList());
  }

  Future<int> add(Category c) async {
    final maxOrder = _t.sortOrder.max();
    final current = await (_db.selectOnly(
      _t,
    )..addColumns([maxOrder])).map((r) => r.read(maxOrder)).getSingle();
    return _db
        .into(_t)
        .insert(
          CategoriesCompanion.insert(
            name: c.name.trim(),
            icon: c.iconKey,
            color: c.colorValue,
            kind: c.kind,
            sortOrder: Value((current ?? -1) + 1),
          ),
        );
  }

  Future<void> update(Category c) => (_db.update(_t)..where((t) => t.id.equals(c.id))).write(
    CategoriesCompanion(
      name: Value(c.name.trim()),
      icon: Value(c.iconKey),
      color: Value(c.colorValue),
      archived: Value(c.archived),
    ),
  );

  /// Borra la categoría si nunca se usó; si tiene movimientos o recurrentes, la archiva.
  Future<CategoryRemoval> remove(int id) => _db.transaction(() async {
    final usedByMovement =
        await (_db.select(_db.movements)
              ..where((m) => m.categoryId.equals(id))
              ..limit(1))
            .getSingleOrNull();
    final usedByRule =
        await (_db.select(_db.recurringRules)
              ..where((r) => r.categoryId.equals(id))
              ..limit(1))
            .getSingleOrNull();
    if (usedByMovement != null || usedByRule != null) {
      await (_db.update(
        _t,
      )..where((t) => t.id.equals(id))).write(const CategoriesCompanion(archived: Value(true)));
      return CategoryRemoval.archived;
    }
    await (_db.delete(_t)..where((t) => t.id.equals(id))).go();
    return CategoryRemoval.deleted;
  });

  Future<bool> nameExists(String name, MovementKind kind, {int? exceptId}) async {
    final rows = await (_db.select(
      _t,
    )..where((t) => t.kind.equalsValue(kind) & t.archived.equals(false))).get();
    final target = name.trim().toLowerCase();
    return rows.any((r) => r.id != exceptId && r.name.trim().toLowerCase() == target);
  }
}

@Riverpod(keepAlive: true)
CategoryRepository categoryRepository(Ref ref) => CategoryRepository(ref.watch(appDatabaseProvider));
