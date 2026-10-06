import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../transactions/domain/movement.dart';
import 'category_catalog.dart';

part 'category.freezed.dart';

@freezed
abstract class Category with _$Category {
  const factory Category({
    @Default(0) int id,
    required String name,
    required String iconKey,
    required int colorValue,
    required MovementKind kind,
    @Default(0) int sortOrder,

    /// Las categorías con historial no se borran: se archivan y dejan de
    /// aparecer al registrar movimientos.
    @Default(false) bool archived,
  }) = _Category;

  const Category._();

  Color get color => Color(colorValue);

  IconData get icon => CategoryCatalog.icon(iconKey);
}

/// Resultado de quitar una categoría.
enum CategoryRemoval { deleted, archived }
