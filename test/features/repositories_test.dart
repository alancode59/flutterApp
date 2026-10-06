import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:finanzas/core/database/app_database.dart';
import 'package:finanzas/features/categories/data/category_repository.dart';
import 'package:finanzas/features/categories/domain/category.dart';
import 'package:finanzas/features/categories/domain/category_catalog.dart';
import 'package:finanzas/features/recurring/data/recurring_repository.dart';
import 'package:finanzas/features/recurring/domain/recurring_rule.dart';
import 'package:finanzas/features/transactions/data/movement_repository.dart';
import 'package:finanzas/features/transactions/domain/movement.dart';
import 'package:finanzas/features/transactions/domain/period.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase db;
  late CategoryRepository categories;
  late MovementRepository movements;
  late RecurringRepository recurring;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    categories = CategoryRepository(db);
    movements = MovementRepository(db);
    recurring = RecurringRepository(db);
  });

  tearDown(() => db.close());

  Future<int> categoryId(String name) async =>
      (await categories.watchAll().first).firstWhere((c) => c.name == name).id;

  Movement expense(int cat, int cents, DateTime date, {String? note}) => Movement(
    kind: MovementKind.expense,
    amountCents: cents,
    categoryId: cat,
    date: date,
    note: note,
    paymentMethod: PaymentMethod.debit,
  );

  group('categorías', () {
    test('se crean las categorías iniciales', () async {
      final all = await categories.watchAll().first;
      expect(all.length, CategoryCatalog.defaults.length);
      expect(all.where((c) => c.kind == MovementKind.income).map((c) => c.name), contains('Nómina'));
    });

    test('ordena por uso reciente', () async {
      final ropa = await categoryId('Ropa');
      await movements.add(expense(ropa, 100, DateTime.now()));
      await movements.add(expense(ropa, 100, DateTime.now()));
      final ordered = await categories.watchByUsage(MovementKind.expense).first;
      expect(ordered.first.name, 'Ropa');
      expect(ordered.every((c) => c.kind == MovementKind.expense), isTrue);
    });

    test('borra si no se usó y archiva si tiene historial', () async {
      final nueva = await categories.add(
        const Category(
          name: 'Café',
          iconKey: 'local_cafe',
          colorValue: 0xFF000000,
          kind: MovementKind.expense,
        ),
      );
      expect(await categories.remove(nueva), CategoryRemoval.deleted);

      final comida = await categoryId('Comida');
      await movements.add(expense(comida, 500, DateTime(2026, 10, 1)));
      expect(await categories.remove(comida), CategoryRemoval.archived);
      final active = await categories.watchByUsage(MovementKind.expense).first;
      expect(active.any((c) => c.id == comida), isFalse);
    });

    test('detecta nombres repetidos sin importar mayúsculas', () async {
      expect(await categories.nameExists('  súper ', MovementKind.expense), isTrue);
      expect(await categories.nameExists('Súper', MovementKind.income), isFalse);
    });
  });

  group('movimientos', () {
    test('filtra por rango con fin exclusivo y ordena del más nuevo', () async {
      final cat = await categoryId('Súper');
      await movements.add(expense(cat, 100, DateTime(2026, 9, 30, 23, 59)));
      await movements.add(expense(cat, 200, DateTime(2026, 10, 1)));
      await movements.add(expense(cat, 300, DateTime(2026, 10, 15, 23, 59)));
      await movements.add(expense(cat, 400, DateTime(2026, 10, 16)));
      final list = await movements.watchRange(DateRange(DateTime(2026, 10, 1), DateTime(2026, 10, 16))).first;
      expect(list.map((m) => m.amountCents), [300, 200]);
    });

    test('borrar y deshacer conserva el id', () async {
      final cat = await categoryId('Súper');
      final id = await movements.add(expense(cat, 999, DateTime(2026, 10, 2), note: 'Despensa'));
      final deleted = await movements.delete(id);
      expect(await movements.watchRecent().first, isEmpty);
      await movements.restore(deleted!);
      final back = await movements.watchRecent().first;
      expect(back.single.id, id);
      expect(back.single.note, 'Despensa');
    });

    test('normaliza campos según el tipo', () async {
      final cat = await categoryId('Nómina');
      final id = await movements.add(
        Movement(
          kind: MovementKind.income,
          amountCents: 100,
          categoryId: cat,
          date: DateTime(2026, 10, 1),
          paymentMethod: PaymentMethod.cash,
          isUnexpected: true,
          incomeSource: '  Empresa  ',
          note: '   ',
        ),
      );
      final m = (await movements.watchRecent().first).firstWhere((m) => m.id == id);
      expect(m.paymentMethod, isNull);
      expect(m.isUnexpected, isFalse);
      expect(m.incomeSource, 'Empresa');
      expect(m.note, isNull);
      expect(await movements.incomeSources(), ['Empresa']);
    });
  });

  group('recurrentes', () {
    test('genera lo pendiente una sola vez', () async {
      final cat = await categoryId('Nómina');
      await recurring.add(
        RecurringRule(
          kind: MovementKind.income,
          name: 'Quincena',
          amountCents: 1425000,
          categoryId: cat,
          frequency: Frequency.biweekly,
          startDate: DateTime(2026, 9, 1),
        ),
      );
      final now = DateTime(2026, 10, 5, 10);
      expect(await recurring.generateDue(now), 2); // 15 y 30 de septiembre
      expect(await recurring.generateDue(now), 0);

      final rule = (await recurring.watchAll().first).single;
      expect(rule.lastGeneratedDate, DateTime(2026, 10, 5));

      expect(await recurring.generateDue(DateTime(2026, 10, 15, 8)), 1);
      final all = await movements.watchRange(DateRange(DateTime(2026), DateTime(2027))).first;
      expect(all.map((m) => m.date), [DateTime(2026, 10, 15), DateTime(2026, 9, 30), DateTime(2026, 9, 15)]);
      expect(all.every((m) => m.recurringRuleId == rule.id && m.note == 'Quincena'), isTrue);
    });

    test('las reglas futuras o inactivas no generan', () async {
      final cat = await categoryId('Servicios');
      final id = await recurring.add(
        RecurringRule(
          kind: MovementKind.expense,
          name: 'Luz',
          amountCents: 50000,
          categoryId: cat,
          frequency: Frequency.monthly,
          startDate: DateTime(2026, 11, 1),
          paymentMethod: PaymentMethod.debit,
        ),
      );
      expect(await recurring.generateDue(DateTime(2026, 10, 5)), 0);
      await recurring.setActive(id, false);
      expect(await recurring.generateDue(DateTime(2026, 12, 5)), 0);
    });

    test('al reactivar no registra lo que correspondía en pausa', () async {
      final cat = await categoryId('Transporte');
      final id = await recurring.add(
        RecurringRule(
          kind: MovementKind.expense,
          name: 'Metro',
          amountCents: 500,
          categoryId: cat,
          frequency: Frequency.weekly,
          startDate: DateTime(2026, 9, 1),
        ),
      );
      await recurring.setActive(id, false);
      await recurring.setActive(id, true, now: DateTime(2026, 10, 6));
      expect(await recurring.generateDue(DateTime(2026, 10, 6)), 1); // solo el martes 6 de octubre
    });

    test('borrar la regla conserva sus movimientos', () async {
      final cat = await categoryId('Suscripciones');
      final id = await recurring.add(
        RecurringRule(
          kind: MovementKind.expense,
          name: 'Streaming',
          amountCents: 21900,
          categoryId: cat,
          frequency: Frequency.monthly,
          startDate: DateTime(2026, 10, 1),
        ),
      );
      await recurring.generateDue(DateTime(2026, 10, 5));
      await recurring.delete(id);
      final list = await movements.watchRecent().first;
      expect(list.single.recurringRuleId, isNull);
    });
  });
}
