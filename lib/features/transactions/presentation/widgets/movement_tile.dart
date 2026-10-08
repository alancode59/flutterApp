import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_tokens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../cards/presentation/card_providers.dart';
import '../../../categories/domain/category.dart';
import '../../../categories/presentation/widgets/category_avatar.dart';
import '../../domain/movement.dart';

class MovementTile extends ConsumerWidget {
  const MovementTile({required this.movement, required this.category, this.onTap, super.key});

  final Movement movement;
  final Category? category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = movement;
    final card = m.cardId == null ? null : ref.watch(cardsByIdProvider).value?[m.cardId];
    final note = m.note?.trim();
    final hasNote = note != null && note.isNotEmpty;
    final title = hasNote ? note : (category?.name ?? 'Sin categoría');
    final detail = m.isExpense ? (card?.shortLabel ?? m.paymentMethod?.label) : m.incomeSource;
    final subtitle = [if (hasNote) category?.name, detail].whereType<String>().join(' · ');
    final amountText = m.isExpense
        ? '-${Formatters.money(m.amountCents)}'
        : '+${Formatters.money(m.amountCents)}';
    final amountColor = m.isExpense ? context.scheme.onSurface : context.colors.income;

    return Semantics(
      button: onTap != null,
      label:
          '$title, ${m.kind.label} de ${Formatters.money(m.amountCents)}'
          '${card != null ? ', con ${card.name}' : ''}'
          '${m.isInstallment ? ', mensualidad ${m.installmentNumber}' : ''}'
          '${m.isUnexpected ? ', imprevisto' : ''}, ${Formatters.date(m.date)}',
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          child: Row(
            children: [
              CategoryAvatar(category: category),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.titleSmall?.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (m.recurringRuleId != null) ...[
                          Icon(Icons.autorenew_rounded, size: 13, color: context.colors.textSecondary),
                          const SizedBox(width: 3),
                        ],
                        Flexible(
                          child: Text(
                            subtitle.isEmpty ? m.kind.label : subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.text.bodySmall,
                          ),
                        ),
                        if (m.isInstallment) ...[
                          const SizedBox(width: 6),
                          _Badge(label: 'MSI ${m.installmentNumber ?? ''}', color: context.scheme.primary),
                        ],
                        if (m.isUnexpected) ...[
                          const SizedBox(width: 6),
                          _Badge(
                            label: 'Imprevisto',
                            icon: Icons.bolt_rounded,
                            color: context.colors.warning,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                amountText,
                style: AppTypography.amount(
                  15,
                  color: amountColor,
                  weight: FontWeight.w600,
                ).copyWith(letterSpacing: 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color, this.icon});

  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 11, color: color),
          Text(
            label,
            style: context.text.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
