// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Todas las tarjetas, incluidas las archivadas (para pintar el historial).

@ProviderFor(allCards)
final allCardsProvider = AllCardsProvider._();

/// Todas las tarjetas, incluidas las archivadas (para pintar el historial).

final class AllCardsProvider
    extends $FunctionalProvider<AsyncValue<List<CreditCard>>, List<CreditCard>, Stream<List<CreditCard>>>
    with $FutureModifier<List<CreditCard>>, $StreamProvider<List<CreditCard>> {
  /// Todas las tarjetas, incluidas las archivadas (para pintar el historial).
  AllCardsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allCardsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allCardsHash();

  @$internal
  @override
  $StreamProviderElement<List<CreditCard>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<CreditCard>> create(Ref ref) {
    return allCards(ref);
  }
}

String _$allCardsHash() => r'16e0baab8135bf2493c4b3c58993650839fc2bde';

@ProviderFor(activeCards)
final activeCardsProvider = ActiveCardsProvider._();

final class ActiveCardsProvider
    extends $FunctionalProvider<AsyncValue<List<CreditCard>>, List<CreditCard>, FutureOr<List<CreditCard>>>
    with $FutureModifier<List<CreditCard>>, $FutureProvider<List<CreditCard>> {
  ActiveCardsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeCardsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeCardsHash();

  @$internal
  @override
  $FutureProviderElement<List<CreditCard>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<CreditCard>> create(Ref ref) {
    return activeCards(ref);
  }
}

String _$activeCardsHash() => r'2a4c51c0c6af6c03c01840a066c80c568e72c738';

@ProviderFor(cardsById)
final cardsByIdProvider = CardsByIdProvider._();

final class CardsByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<int, CreditCard>>,
          Map<int, CreditCard>,
          FutureOr<Map<int, CreditCard>>
        >
    with $FutureModifier<Map<int, CreditCard>>, $FutureProvider<Map<int, CreditCard>> {
  CardsByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cardsByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cardsByIdHash();

  @$internal
  @override
  $FutureProviderElement<Map<int, CreditCard>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<int, CreditCard>> create(Ref ref) {
    return cardsById(ref);
  }
}

String _$cardsByIdHash() => r'46c45c80aa4a75f93f84d12d76d5a0da8ce09ee8';

@ProviderFor(creditCharges)
final creditChargesProvider = CreditChargesProvider._();

final class CreditChargesProvider
    extends $FunctionalProvider<AsyncValue<List<Movement>>, List<Movement>, Stream<List<Movement>>>
    with $FutureModifier<List<Movement>>, $StreamProvider<List<Movement>> {
  CreditChargesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'creditChargesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$creditChargesHash();

  @$internal
  @override
  $StreamProviderElement<List<Movement>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Movement>> create(Ref ref) {
    return creditCharges(ref);
  }
}

String _$creditChargesHash() => r'8e27b8674e04efd88e40bb38dcebf7e9bdc6665a';

@ProviderFor(cardPayments)
final cardPaymentsProvider = CardPaymentsProvider._();

final class CardPaymentsProvider
    extends $FunctionalProvider<AsyncValue<List<CardPayment>>, List<CardPayment>, Stream<List<CardPayment>>>
    with $FutureModifier<List<CardPayment>>, $StreamProvider<List<CardPayment>> {
  CardPaymentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cardPaymentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cardPaymentsHash();

  @$internal
  @override
  $StreamProviderElement<List<CardPayment>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<CardPayment>> create(Ref ref) {
    return cardPayments(ref);
  }
}

String _$cardPaymentsHash() => r'd2db89113ec15d6a508f77dbef0de63e582e0bc3';

@ProviderFor(installmentPlans)
final installmentPlansProvider = InstallmentPlansProvider._();

final class InstallmentPlansProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<InstallmentPlan>>,
          List<InstallmentPlan>,
          Stream<List<InstallmentPlan>>
        >
    with $FutureModifier<List<InstallmentPlan>>, $StreamProvider<List<InstallmentPlan>> {
  InstallmentPlansProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'installmentPlansProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$installmentPlansHash();

  @$internal
  @override
  $StreamProviderElement<List<InstallmentPlan>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<InstallmentPlan>> create(Ref ref) {
    return installmentPlans(ref);
  }
}

String _$installmentPlansHash() => r'63a85e71864f89f34c0d94f0c14930649b231450';

/// Resumen (corte, pagos, utilización) de cada tarjeta activa.

@ProviderFor(cardSummaries)
final cardSummariesProvider = CardSummariesProvider._();

/// Resumen (corte, pagos, utilización) de cada tarjeta activa.

final class CardSummariesProvider
    extends $FunctionalProvider<AsyncValue<List<CardSummary>>, List<CardSummary>, FutureOr<List<CardSummary>>>
    with $FutureModifier<List<CardSummary>>, $FutureProvider<List<CardSummary>> {
  /// Resumen (corte, pagos, utilización) de cada tarjeta activa.
  CardSummariesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cardSummariesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cardSummariesHash();

  @$internal
  @override
  $FutureProviderElement<List<CardSummary>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<CardSummary>> create(Ref ref) {
    return cardSummaries(ref);
  }
}

String _$cardSummariesHash() => r'c0f594310273a77678088f3ede8acf4f90408362';

/// La tarjeta cuyo pago vence primero y aún tiene algo que pagar.

@ProviderFor(nextCardPayment)
final nextCardPaymentProvider = NextCardPaymentProvider._();

/// La tarjeta cuyo pago vence primero y aún tiene algo que pagar.

final class NextCardPaymentProvider
    extends $FunctionalProvider<AsyncValue<CardSummary?>, CardSummary?, FutureOr<CardSummary?>>
    with $FutureModifier<CardSummary?>, $FutureProvider<CardSummary?> {
  /// La tarjeta cuyo pago vence primero y aún tiene algo que pagar.
  NextCardPaymentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nextCardPaymentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nextCardPaymentHash();

  @$internal
  @override
  $FutureProviderElement<CardSummary?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<CardSummary?> create(Ref ref) {
    return nextCardPayment(ref);
  }
}

String _$nextCardPaymentHash() => r'ecb3bef213fc58b3a3a59357c16990cf14295805';
