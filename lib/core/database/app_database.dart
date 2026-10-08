import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/cards/domain/credit_card.dart';
import '../../features/categories/domain/category_catalog.dart';
import '../../features/recurring/domain/recurring_rule.dart';
import '../../features/transactions/domain/movement.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    SettingsEntries,
    Categories,
    RecurringRules,
    Movements,
    CreditCards,
    InstallmentPlans,
    CardPayments,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Constructor para pruebas (por ejemplo `NativeDatabase.memory()`).
  AppDatabase(super.executor);

  AppDatabase.defaults()
    : super(
        driftDatabase(
          name: 'finanzas',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seedCategories();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(categories);
        await m.createTable(recurringRules);
        await m.createTable(movements);
        await m.createIndex(movementsDate);
        await _seedCategories();
      }
      if (from < 3) {
        await m.createTable(creditCards);
        await m.createTable(installmentPlans);
        await m.createTable(cardPayments);
        await m.createIndex(cardPaymentsCard);
        // En una base creada en v2 la tabla movements ya existe sin estas columnas.
        if (from >= 2) {
          await m.addColumn(movements, movements.installmentPlanId);
          await m.addColumn(movements, movements.installmentNumber);
        }
      }
      // Desde v3 las tarjetas ya existen; en bases más viejas se crean completas arriba.
      if (from == 3) {
        await m.addColumn(creditCards, creditCards.balanceDate);
        await m.addColumn(creditCards, creditCards.statementRemaining);
        await m.addColumn(creditCards, creditCards.minimumPayment);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> _seedCategories() => batch((b) {
    b.insertAll(categories, [
      for (final (i, (name, icon, color, kind)) in CategoryCatalog.defaults.indexed)
        CategoriesCompanion.insert(name: name, icon: icon, color: color, kind: kind, sortOrder: Value(i)),
    ]);
  });
}

/// Se abre en `main()` antes de pintar la app y se inyecta con un override.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) => throw UnimplementedError('appDatabaseProvider se sobrescribe en main()');
