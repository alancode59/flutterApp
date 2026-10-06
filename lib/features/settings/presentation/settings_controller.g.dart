// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ajustes leídos antes del primer frame, para no parpadear de tema al abrir.

@ProviderFor(initialSettings)
final initialSettingsProvider = InitialSettingsProvider._();

/// Ajustes leídos antes del primer frame, para no parpadear de tema al abrir.

final class InitialSettingsProvider extends $FunctionalProvider<AppSettings, AppSettings, AppSettings>
    with $Provider<AppSettings> {
  /// Ajustes leídos antes del primer frame, para no parpadear de tema al abrir.
  InitialSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initialSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initialSettingsHash();

  @$internal
  @override
  $ProviderElement<AppSettings> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  AppSettings create(Ref ref) {
    return initialSettings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSettings value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<AppSettings>(value));
  }
}

String _$initialSettingsHash() => r'd5ee46e2c1ea2acdec19e347aba2608a803ec69c';

@ProviderFor(SettingsController)
final settingsControllerProvider = SettingsControllerProvider._();

final class SettingsControllerProvider extends $NotifierProvider<SettingsController, AppSettings> {
  SettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsControllerHash();

  @$internal
  @override
  SettingsController create() => SettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSettings value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<AppSettings>(value));
  }
}

String _$settingsControllerHash() => r'96c9a50907b4def587c1c2d1b76f4a2517aa7028';

abstract class _$SettingsController extends $Notifier<AppSettings> {
  AppSettings build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppSettings, AppSettings>;
    final element =
        ref.element
            as $ClassProviderElement<AnyNotifier<AppSettings, AppSettings>, AppSettings, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
