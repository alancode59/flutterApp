import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_tokens.dart';

/// Estado vacío: ícono, mensaje y una acción sugerida.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.actionIcon,
    this.onAction,
    this.compact = false,
    super.key,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onAction;

  /// Versión para usarse dentro de una tarjeta del dashboard.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final badge = compact ? 56.0 : 88.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: compact ? AppSpacing.lg : AppSpacing.xxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            [
                  Container(
                        width: badge,
                        height: badge,
                        decoration: BoxDecoration(
                          color: context.scheme.primaryContainer,
                          borderRadius: BorderRadius.circular(badge * 0.32),
                        ),
                        child: Icon(icon, size: badge * 0.45, color: context.scheme.primary),
                      )
                      .animate()
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        curve: AppCurves.spring,
                        duration: AppDurations.slow,
                      )
                      .fadeIn(duration: AppDurations.medium),
                  SizedBox(height: compact ? AppSpacing.sm : AppSpacing.lg),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: compact ? context.text.titleMedium : context.text.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.text.bodyMedium?.copyWith(color: context.colors.textSecondary),
                  ),
                  if (actionLabel != null && onAction != null) ...[
                    SizedBox(height: compact ? AppSpacing.md : AppSpacing.xl),
                    FilledButton.icon(
                      onPressed: onAction,
                      icon: Icon(actionIcon ?? Icons.add_rounded),
                      label: Text(actionLabel!),
                    ),
                  ],
                ]
                .animate(interval: 60.ms, delay: 80.ms)
                .fadeIn(duration: AppDurations.medium)
                .slideY(begin: 0.15, curve: AppCurves.standard),
      ),
    );
  }
}
