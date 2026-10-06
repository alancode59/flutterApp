// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Filtros de la pantalla de Movimientos. Se conservan al cambiar de pestaña.

@ProviderFor(MovementsFilter)
final movementsFilterProvider = MovementsFilterProvider._();

/// Filtros de la pantalla de Movimientos. Se conservan al cambiar de pestaña.
final class MovementsFilterProvider extends $NotifierProvider<MovementsFilter, MovementsFilterState> {
  /// Filtros de la pantalla de Movimientos. Se conservan al cambiar de pestaña.
  MovementsFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'movementsFilterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$movementsFilterHash();

  @$internal
  @override
  MovementsFilter create() => MovementsFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MovementsFilterState value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<MovementsFilterState>(value));
  }
}

String _$movementsFilterHash() => r'85238fdd0dd5eab5e55a01612497f1e935f116d6';

/// Filtros de la pantalla de Movimientos. Se conservan al cambiar de pestaña.

abstract class _$MovementsFilter extends $Notifier<MovementsFilterState> {
  MovementsFilterState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MovementsFilterState, MovementsFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MovementsFilterState, MovementsFilterState>,
              MovementsFilterState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(movementsInRange)
final movementsInRangeProvider = MovementsInRangeFamily._();

final class MovementsInRangeProvider
    extends $FunctionalProvider<AsyncValue<List<Movement>>, List<Movement>, Stream<List<Movement>>>
    with $FutureModifier<List<Movement>>, $StreamProvider<List<Movement>> {
  MovementsInRangeProvider._({required MovementsInRangeFamily super.from, required DateRange super.argument})
    : super(
        retry: null,
        name: r'movementsInRangeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$movementsInRangeHash();

  @override
  String toString() {
    return r'movementsInRangeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Movement>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Movement>> create(Ref ref) {
    final argument = this.argument as DateRange;
    return movementsInRange(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MovementsInRangeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$movementsInRangeHash() => r'e17ab0c1893ff68fac20c63b0ddba6e85da8ac7e';

final class MovementsInRangeFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Movement>>, DateRange> {
  MovementsInRangeFamily._()
    : super(
        retry: null,
        name: r'movementsInRangeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MovementsInRangeProvider call(DateRange range) => MovementsInRangeProvider._(argument: range, from: this);

  @override
  String toString() => r'movementsInRangeProvider';
}

@ProviderFor(recentMovements)
final recentMovementsProvider = RecentMovementsProvider._();

final class RecentMovementsProvider
    extends $FunctionalProvider<AsyncValue<List<Movement>>, List<Movement>, Stream<List<Movement>>>
    with $FutureModifier<List<Movement>>, $StreamProvider<List<Movement>> {
  RecentMovementsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentMovementsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentMovementsHash();

  @$internal
  @override
  $StreamProviderElement<List<Movement>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Movement>> create(Ref ref) {
    return recentMovements(ref);
  }
}

String _$recentMovementsHash() => r'6fd6b333828e3bc25c3405b439d53ebb583bce5c';

@ProviderFor(currentQuincenaMovements)
final currentQuincenaMovementsProvider = CurrentQuincenaMovementsProvider._();

final class CurrentQuincenaMovementsProvider
    extends $FunctionalProvider<AsyncValue<List<Movement>>, List<Movement>, Stream<List<Movement>>>
    with $FutureModifier<List<Movement>>, $StreamProvider<List<Movement>> {
  CurrentQuincenaMovementsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentQuincenaMovementsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentQuincenaMovementsHash();

  @$internal
  @override
  $StreamProviderElement<List<Movement>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Movement>> create(Ref ref) {
    return currentQuincenaMovements(ref);
  }
}

String _$currentQuincenaMovementsHash() => r'b6ac064600bff6568569e6226ff61369691b2cb3';
