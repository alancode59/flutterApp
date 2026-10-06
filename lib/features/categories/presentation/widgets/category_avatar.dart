import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/category.dart';

/// Ícono de la categoría sobre un cuadro redondeado con su color.
class CategoryAvatar extends StatelessWidget {
  const CategoryAvatar({required this.category, this.size = 44, super.key});

  /// Null mientras cargan las categorías.
  final Category? category;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = category?.color ?? context.colors.textSecondary;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      child: Icon(category?.icon ?? Icons.category_rounded, color: color, size: size * 0.5),
    );
  }
}
