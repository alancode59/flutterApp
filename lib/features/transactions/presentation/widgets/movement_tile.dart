import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_tokens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../categories/domain/category.dart';
import '../../../categories/presentation/widgets/category_avatar.dart';
import '../../domain/movement.dart';

class MovementTile extends StatelessWidget {
  const MovementTile({required this.movement, required this.category, this.onTap, super.key});

  final Movement movement;
  final Category? category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final m = movement;
    final note = m.note?.trim();
    final hasNote = note != null && note.isNotEmpty;
    final title = hasNote ? note : (category?.name ?? 'Sin categoría');
    final detail = m.isExpense ? m.paymentMethod?.label : m.incomeSource;
    final subtitle = [if (hasNote) category?.name, detail].whereType<String>().join(' · ');
    final amountText = m.isExpense
        ? '-${Formatters.money(m.amountCents)}'
        : '+${Formatters.money(m.amountCents)}';
    final amountColor = m.isExpense ? context.scheme.onSurface : context.colors.income;

    return Semantics(
      button: onTap != null,
      label:
          '$title, ${m.kind.label} de ${Formatters.money(m.amountCents)}'
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
                        if (m.isUnexpected) ...[const SizedBox(width: 6), const _UnexpectedBadge()],
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

class _UnexpectedBadge extends StatelessWidget {
  const _UnexpectedBadge();

  @override
  Widget build(BuildContext context) {
    final color = context.colors.warning;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt_rounded, size: 11, color: color),
          Text(
            'Imprevisto',
            style: context.text.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
