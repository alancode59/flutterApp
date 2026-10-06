// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Todas las categorías (incluidas archivadas) para pintar el historial.

@ProviderFor(allCategories)
final allCategoriesProvider = AllCategoriesProvider._();

/// Todas las categorías (incluidas archivadas) para pintar el historial.

final class AllCategoriesProvider
    extends $FunctionalProvider<AsyncValue<List<Category>>, List<Category>, Stream<List<Category>>>
    with $FutureModifier<List<Category>>, $StreamProvider<List<Category>> {
  /// Todas las categorías (incluidas archivadas) para pintar el historial.
  AllCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allCategoriesHash();

  @$internal
  @override
  $StreamProviderElement<List<Category>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Category>> create(Ref ref) {
    return allCategories(ref);
  }
}

String _$allCategoriesHash() => r'522e0951601cf3ffbe437e10a63eee29bcb038de';

@ProviderFor(categoriesById)
final categoriesByIdProvider = CategoriesByIdProvider._();

final class CategoriesByIdProvider
    extends
        $FunctionalProvider<AsyncValue<Map<int, Category>>, Map<int, Category>, FutureOr<Map<int, Category>>>
    with $FutureModifier<Map<int, Category>>, $FutureProvider<Map<int, Category>> {
  CategoriesByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesByIdHash();

  @$internal
  @override
  $FutureProviderElement<Map<int, Category>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<int, Category>> create(Ref ref) {
    return categoriesById(ref);
  }
}

String _$categoriesByIdHash() => r'83fe5cca15cc3b7e35c351e8c91b23ed9cd25f9d';

/// Categorías activas de un tipo, las más usadas primero.

@ProviderFor(categoriesByUsage)
final categoriesByUsageProvider = CategoriesByUsageFamily._();

/// Categorías activas de un tipo, las más usadas primero.

final class CategoriesByUsageProvider
    extends $FunctionalProvider<AsyncValue<List<Category>>, List<Category>, Stream<List<Category>>>
    with $FutureModifier<List<Category>>, $StreamProvider<List<Category>> {
  /// Categorías activas de un tipo, las más usadas primero.
  CategoriesByUsageProvider._({
    required CategoriesByUsageFamily super.from,
    required MovementKind super.argument,
  }) : super(
         retry: null,
         name: r'categoriesByUsageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoriesByUsageHash();

  @override
  String toString() {
    return r'categoriesByUsageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Category>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Category>> create(Ref ref) {
    final argument = this.argument as MovementKind;
    return categoriesByUsage(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoriesByUsageProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoriesByUsageHash() => r'67354770acee75704a1a2520255d2eea07a8c29f';

/// Categorías activas de un tipo, las más usadas primero.

final class CategoriesByUsageFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Category>>, MovementKind> {
  CategoriesByUsageFamily._()
    : super(
        retry: null,
        name: r'categoriesByUsageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Categorías activas de un tipo, las más usadas primero.

  CategoriesByUsageProvider call(MovementKind kind) =>
      CategoriesByUsageProvider._(argument: kind, from: this);

  @override
  String toString() => r'categoriesByUsageProvider';
}
