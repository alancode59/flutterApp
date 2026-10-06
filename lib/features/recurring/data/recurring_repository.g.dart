// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recurringRepository)
final recurringRepositoryProvider = RecurringRepositoryProvider._();

final class RecurringRepositoryProvider
    extends $FunctionalProvider<RecurringRepository, RecurringRepository, RecurringRepository>
    with $Provider<RecurringRepository> {
  RecurringRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringRepositoryHash();

  @$internal
  @override
  $ProviderElement<RecurringRepository> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  RecurringRepository create(Ref ref) {
    return recurringRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecurringRepository value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<RecurringRepository>(value));
  }
}

String _$recurringRepositoryHash() => r'eda3e86ceac2cbfc5fea101413e45a6600a0d798';
