import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../core/widgets/pressable.dart';

/// Hoja de alta rápida. En la Fase 1 solo muestra las opciones; el registro
/// con teclado numérico y categorías llega en la Fase 2.
Future<void> showQuickAddSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (_) => const _QuickAddSheet(),
  );
}

class _QuickAddSheet extends StatelessWidget {
  const _QuickAddSheet();

  @override
  Widget build(BuildContext context) {
    final options = [
      (Icons.south_west_rounded, 'Gasto', 'Compra, servicio o imprevisto', context.colors.expense),
      (Icons.north_east_rounded, 'Ingreso', 'Quincena, extra o venta', context.colors.income),
      (
        Icons.credit_score_rounded,
        'Pago de tarjeta',
        'Abono a una tarjeta de crédito',
        context.scheme.primary,
      ),
      (Icons.handshake_outlined, 'Deuda o préstamo', 'Lo que debo o me deben', context.colors.warning),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.page, 0, AppSpacing.page, AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Nuevo movimiento', style: context.text.headlineSmall),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'El registro rápido estará disponible en la Fase 2.',
            style: context.text.bodyMedium?.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...[
            for (final (icon, title, subtitle, color) in options)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: _OptionTile(icon: icon, title: title, subtitle: subtitle, color: color),
              ),
          ].animate(interval: 40.ms).fadeIn(duration: AppDurations.medium).slideY(begin: 0.2),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({required this.icon, required this.title, required this.subtitle, required this.color});

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      semanticLabel: '$title, próximamente',
      onTap: () {
        final messenger = ScaffoldMessenger.of(context);
        Navigator.of(context).pop();
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('"$title" estará disponible pronto.')));
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: context.colors.surfaceHigh,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.text.titleMedium),
                  Text(subtitle, style: context.text.bodySmall),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: context.colors.textSecondary),
          ],
        ),
      ),
    );
  }
}
