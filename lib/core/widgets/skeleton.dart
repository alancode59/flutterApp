import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_tokens.dart';

/// Bloque gris con brillo animado, para mostrar mientras cargan los datos.
class Skeleton extends StatelessWidget {
  const Skeleton({this.width, this.height = 16, this.radius = AppRadius.sm, super.key});

  const Skeleton.circle({required double size, super.key})
    : width = size,
      height = size,
      radius = AppRadius.pill;

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final base = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.colors.surfaceHigh,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
    if (MediaQuery.disableAnimationsOf(context)) return base;

    return base
        .animate(onPlay: (c) => c.repeat())
        .shimmer(duration: 1200.ms, color: context.scheme.surface.withValues(alpha: 0.55));
  }
}

/// Esqueleto de una fila de movimiento (ícono, dos líneas y monto).
class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Row(
        children: [
          Skeleton(width: 44, height: 44, radius: AppRadius.md),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(width: 140, height: 14),
                SizedBox(height: AppSpacing.xs),
                Skeleton(width: 90, height: 12),
              ],
            ),
          ),
          Skeleton(width: 72, height: 16),
        ],
      ),
    );
  }
}

/// Esqueleto de una lista con [count] filas.
class SkeletonList extends StatelessWidget {
  const SkeletonList({this.count = 5, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Cargando',
      child: Column(children: List.generate(count, (_) => const SkeletonListTile())),
    );
  }
}
