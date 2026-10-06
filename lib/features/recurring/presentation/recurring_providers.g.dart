// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recurringRules)
final recurringRulesProvider = RecurringRulesProvider._();

final class RecurringRulesProvider
    extends
        $FunctionalProvider<AsyncValue<List<RecurringRule>>, List<RecurringRule>, Stream<List<RecurringRule>>>
    with $FutureModifier<List<RecurringRule>>, $StreamProvider<List<RecurringRule>> {
  RecurringRulesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringRulesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringRulesHash();

  @$internal
  @override
  $StreamProviderElement<List<RecurringRule>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<RecurringRule>> create(Ref ref) {
    return recurringRules(ref);
  }
}

String _$recurringRulesHash() => r'b0203c9e6439ab1e83fc1ce246d06abcd2dba056';
