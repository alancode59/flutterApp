import 'package:drift/drift.dart';

import '../../features/recurring/domain/recurring_rule.dart';
import '../../features/transactions/domain/movement.dart';

/// Preferencias de la app como pares clave/valor. Evita una migración cada vez
/// que se agrega un ajuste nuevo.
@DataClassName('SettingsEntry')
class SettingsEntries extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DataClassName('CategoryRow')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 40)();
  TextColumn get icon => text()();
  IntColumn get color => integer()();
  TextColumn get kind => textEnum<MovementKind>()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
}

@DataClassName('RecurringRuleRow')
class RecurringRules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get kind => textEnum<MovementKind>()();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  // ignore: recursive_getters (así declara Drift las restricciones CHECK)
  IntColumn get amount => integer().check(amount.isBiggerThanValue(0))();
  IntColumn get categoryId => integer().references(Categories, #id)();
  TextColumn get frequency => textEnum<Frequency>()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get paymentMethod => textEnum<PaymentMethod>().nullable()();
  IntColumn get cardId => integer().nullable()();
  TextColumn get incomeSource => text().nullable()();
  DateTimeColumn get lastGeneratedDate => dateTime().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
}

@DataClassName('MovementRow')
@TableIndex(name: 'movements_date', columns: {#date})
class Movements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get kind => textEnum<MovementKind>()();
  // ignore: recursive_getters (así declara Drift las restricciones CHECK)
  IntColumn get amount => integer().check(amount.isBiggerThanValue(0))();
  IntColumn get categoryId => integer().references(Categories, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().nullable()();
  TextColumn get paymentMethod => textEnum<PaymentMethod>().nullable()();
  IntColumn get cardId => integer().nullable()();
  BoolColumn get isUnexpected => boolean().withDefault(const Constant(false))();
  TextColumn get incomeSource => text().nullable()();
  IntColumn get recurringRuleId =>
      integer().nullable().references(RecurringRules, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Una regla recurrente no puede generar dos movimientos el mismo día.
  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {recurringRuleId, date},
  ];
}
