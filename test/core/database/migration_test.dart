import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:finanzas/core/database/app_database.dart';
import 'package:finanzas/features/cards/data/card_repository.dart';
import 'package:finanzas/features/cards/domain/credit_card.dart';
import 'package:finanzas/features/transactions/data/movement_repository.dart';
import 'package:finanzas/features/transactions/domain/movement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  test('una base v2 con movimientos pasa a la versión actual sin perder datos', () async {
    final dir = await Directory.systemTemp.createTemp('finanzas_migracion');
    final file = File('${dir.path}/finanzas.sqlite');

    // 1. Crea la base actual con un movimiento y la "regresa" a como era en v2.
    var db = AppDatabase(NativeDatabase(file));
    final cat = (await db.select(db.categories).get()).first.id;
    await MovementRepository(db).add(
      Movement(
        kind: MovementKind.expense,
        amountCents: 4200,
        categoryId: cat,
        date: DateTime(2026, 10, 1),
        note: 'Antes de la v3',
        paymentMethod: PaymentMethod.cash,
      ),
    );
    await db.customStatement('PRAGMA foreign_keys = OFF');
    await db.customStatement('ALTER TABLE movements DROP COLUMN installment_plan_id');
    await db.customStatement('ALTER TABLE movements DROP COLUMN installment_number');
    for (final t in ['card_payments', 'installment_plans', 'credit_cards']) {
      await db.customStatement('DROP TABLE $t');
    }
    await db.customStatement('PRAGMA user_version = 2');
    await db.close();

    // 2. Al abrir, migra: el movimiento sigue y las tarjetas funcionan.
    db = AppDatabase(NativeDatabase(file));
    final movements = await MovementRepository(db).watchRecent().first;
    expect(movements.single.note, 'Antes de la v3');
    expect(movements.single.installmentPlanId, isNull);

    final cards = CardRepository(db);
    await cards.add(
      CreditCard(name: 'Oro', limitCents: 100, cutoffDay: 1, dueDay: 20, createdAt: DateTime(2026)),
    );
    expect((await cards.watchAll().first).single.name, 'Oro');
    final version = await db.customSelect('PRAGMA user_version').getSingle();
    expect(version.data.values.first, 4);

    await db.close();
    await dir.delete(recursive: true);
  });

  test('una base v3 con tarjetas conserva la tarjeta y suma los saldos del banco', () async {
    final dir = await Directory.systemTemp.createTemp('finanzas_migracion_v3');
    final file = File('${dir.path}/finanzas.sqlite');

    var db = AppDatabase(NativeDatabase(file));
    await CardRepository(db).add(
      CreditCard(
        name: 'Azul',
        limitCents: 1370000,
        cutoffDay: 4,
        dueDay: 26,
        openingBalanceCents: 704048,
        createdAt: DateTime(2026, 10, 7),
      ),
    );
    for (final c in ['balance_date', 'statement_remaining', 'minimum_payment']) {
      await db.customStatement('ALTER TABLE credit_cards DROP COLUMN $c');
    }
    await db.customStatement('PRAGMA user_version = 3');
    await db.close();

    db = AppDatabase(NativeDatabase(file));
    final repo = CardRepository(db);
    final azul = (await repo.watchAll().first).single;
    expect(azul.name, 'Azul');
    expect(azul.openingBalanceCents, 704048);
    expect(azul.balanceDate, isNull);
    await repo.update(azul.copyWith(balanceDate: DateTime(2026, 10, 7, 9), statementRemainingCents: 347622));
    expect((await repo.watchAll().first).single.statementRemainingCents, 347622);

    await db.close();
    await dir.delete(recursive: true);
  });
}
