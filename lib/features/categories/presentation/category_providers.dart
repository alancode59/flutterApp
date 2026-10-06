import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../transactions/domain/movement.dart';
import '../data/category_repository.dart';
import '../domain/category.dart';

part 'category_providers.g.dart';

/// Todas las categorías (incluidas archivadas) para pintar el historial.
@riverpod
Stream<List<Category>> allCategories(Ref ref) => ref.watch(categoryRepositoryProvider).watchAll();

@riverpod
Future<Map<int, Category>> categoriesById(Ref ref) async {
  final list = await ref.watch(allCategoriesProvider.future);
  return {for (final c in list) c.id: c};
}

/// Categorías activas de un tipo, las más usadas primero.
@riverpod
Stream<List<Category>> categoriesByUsage(Ref ref, MovementKind kind) =>
    ref.watch(categoryRepositoryProvider).watchByUsage(kind);
