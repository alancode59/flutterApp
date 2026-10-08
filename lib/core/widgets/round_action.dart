import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import 'pressable.dart';

/// Botón circular con etiqueta, al estilo de las acciones rápidas de un banco.
class RoundAction extends StatelessWidget {
  const RoundAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.filled = false,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      scale: 0.9,
      semanticLabel: label,
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: filled ? context.scheme.primary : context.colors.surfaceHigh,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: filled ? context.scheme.onPrimary : context.scheme.onSurface,
                size: 22,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.text.labelMedium?.copyWith(color: context.scheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
