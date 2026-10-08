import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../transactions/domain/movement.dart';
import '../data/card_repository.dart';
import '../domain/card_payment.dart';
import '../domain/card_summary.dart';
import '../domain/credit_card.dart';
import '../domain/installment_plan.dart';

part 'card_providers.g.dart';

/// Todas las tarjetas, incluidas las archivadas (para pintar el historial).
@riverpod
Stream<List<CreditCard>> allCards(Ref ref) => ref.watch(cardRepositoryProvider).watchAll();

@riverpod
Future<List<CreditCard>> activeCards(Ref ref) async =>
    (await ref.watch(allCardsProvider.future)).where((c) => !c.archived).toList();

@riverpod
Future<Map<int, CreditCard>> cardsById(Ref ref) async => {
  for (final c in await ref.watch(allCardsProvider.future)) c.id: c,
};

@riverpod
Stream<List<Movement>> creditCharges(Ref ref) => ref.watch(cardRepositoryProvider).watchCharges();

@riverpod
Stream<List<CardPayment>> cardPayments(Ref ref) => ref.watch(cardRepositoryProvider).watchPayments();

@riverpod
Stream<List<InstallmentPlan>> installmentPlans(Ref ref) => ref.watch(cardRepositoryProvider).watchPlans();

/// Resumen (corte, pagos, utilización) de cada tarjeta activa.
@riverpod
Future<List<CardSummary>> cardSummaries(Ref ref) async {
  final cards = await ref.watch(activeCardsProvider.future);
  final charges = groupBy(await ref.watch(creditChargesProvider.future), (Movement m) => m.cardId);
  final payments = groupBy(await ref.watch(cardPaymentsProvider.future), (CardPayment p) => p.cardId);
  final purchaseDates = {
    for (final p in await ref.watch(installmentPlansProvider.future)) p.id: p.purchaseDate,
  };
  final now = DateTime.now();
  return [
    for (final card in cards)
      CardSummary.compute(
        card: card,
        charges: charges[card.id] ?? const [],
        payments: payments[card.id] ?? const [],
        now: now,
        planPurchaseDates: purchaseDates,
      ),
  ];
}

/// La tarjeta cuyo pago vence primero y aún tiene algo que pagar.
@riverpod
Future<CardSummary?> nextCardPayment(Ref ref) async {
  final summaries = await ref.watch(cardSummariesProvider.future);
  final due = summaries.where((s) => s.nextDueCents > 0).toList()
    ..sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));
  return due.firstOrNull;
}
