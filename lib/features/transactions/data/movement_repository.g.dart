// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(movementRepository)
final movementRepositoryProvider = MovementRepositoryProvider._();

final class MovementRepositoryProvider
    extends $FunctionalProvider<MovementRepository, MovementRepository, MovementRepository>
    with $Provider<MovementRepository> {
  MovementRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'movementRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$movementRepositoryHash();

  @$internal
  @override
  $ProviderElement<MovementRepository> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  MovementRepository create(Ref ref) {
    return movementRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MovementRepository value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<MovementRepository>(value));
  }
}

String _$movementRepositoryHash() => r'b0529c8675b6b4af604814a4c869caef2acd7bdb';
