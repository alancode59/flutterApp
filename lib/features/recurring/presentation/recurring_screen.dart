import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/services/haptics.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_reveal.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/skeleton.dart';
import '../../categories/data/category_repository.dart';
import '../../categories/domain/category.dart';
import '../../categories/presentation/category_providers.dart';
import '../../categories/presentation/widgets/category_avatar.dart';
import '../../transactions/domain/movement.dart';
import '../data/recurring_repository.dart';
import '../domain/recurrence.dart';
import '../domain/recurring_rule.dart';
import 'recurring_editor_sheet.dart';
import 'recurring_providers.dart';

class RecurringScreen extends ConsumerWidget {
  const RecurringScreen({super.key});

  /// Precarga "Quincena" como ingreso quincenal en la categoría Nómina.
  Future<void> _setupPaycheck(BuildContext context, WidgetRef ref) async {
    final incomes = await ref.read(categoryRepositoryProvider).watchByUsage(MovementKind.income).first;
    if (!context.mounted) return;
    final nomina = incomes.firstWhereOrNull((c) => c.name == 'Nómina') ?? incomes.firstOrNull;
    await showRecurringEditor(
      context,
      preset: RecurringRule(
        kind: MovementKind.income,
        name: 'Quincena',
        amountCents: 0,
        categoryId: nomina?.id ?? 0,
        frequency: Frequency.biweekly,
        startDate: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rules = ref.watch(recurringRulesProvider);
    final categories = ref.watch(categoriesByIdProvider).value ?? const <int, Category>{};

    return PageScaffold(
      title: 'Recurrentes',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showRecurringEditor(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nuevo'),
      ),
      slivers: [
        SliverToBoxAdapter(
          child: AsyncReveal<List<RecurringRule>>(
            value: rules,
            skeleton: const Padding(
              padding: EdgeInsets.all(AppSpacing.page),
              child: Card(child: SkeletonList(count: 4)),
            ),
            builder: (list) {
              if (list.isEmpty) {
                return Column(
                  children: [
                    EmptyState(
                      icon: Icons.autorenew_rounded,
                      title: 'Automatiza lo que se repite',
                      message:
                          'Tu quincena, la renta o tus suscripciones se registran solas en cada periodo.',
                      actionLabel: 'Configurar mi quincena',
                      actionIcon: Icons.work_rounded,
                      onAction: () => _setupPaycheck(context, ref),
                    ),
                    TextButton(
                      onPressed: () => showRecurringEditor(context),
                      child: const Text('Agregar un pago recurrente'),
                    ),
                  ],
                );
              }
              final incomes = list.where((r) => r.kind == MovementKind.income).toList();
              final expenses = list.where((r) => r.kind == MovementKind.expense).toList();
              final monthlyExpense = expenses
                  .where((r) => r.active)
                  .fold<double>(0, (sum, r) => sum + r.amountCents * _perMonth(r.frequency));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (expenses.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.page, 0, AppSpacing.page, 0),
                      child: Text(
                        'Pagos fijos: ${Formatters.money(monthlyExpense.round())} al mes aprox.',
                        style: context.text.bodyMedium?.copyWith(color: context.colors.textSecondary),
                      ),
                    ),
                  if (incomes.isNotEmpty) ...[
                    const SectionHeader(title: 'Ingresos'),
                    _RuleGroup(rules: incomes, categories: categories),
                  ],
                  if (expenses.isNotEmpty) ...[
                    const SectionHeader(title: 'Gastos'),
                    _RuleGroup(rules: expenses, categories: categories),
                  ],
                  const SizedBox(height: 88),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  static double _perMonth(Frequency f) => switch (f) {
    Frequency.weekly => 52 / 12,
    Frequency.biweekly => 2,
    Frequency.monthly => 1,
    Frequency.yearly => 1 / 12,
  };
}

class _RuleGroup extends ConsumerWidget {
  const _RuleGroup({required this.rules, required this.categories});

  final List<RecurringRule> rules;
  final Map<int, Category> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
      child: Card(
        child: Column(
          children: [
            for (final r in rules)
              _RuleTile(
                key: ValueKey(r.id),
                rule: r,
                category: categories[r.categoryId],
                onToggle: (v) {
                  Haptics.tap();
                  ref.read(recurringRepositoryProvider).setActive(r.id, v);
                },
              ),
          ].animate(interval: 30.ms).fadeIn(duration: AppDurations.medium),
        ),
      ),
    );
  }
}

class _RuleTile extends StatelessWidget {
  const _RuleTile({required this.rule, required this.category, required this.onToggle, super.key});

  final RecurringRule rule;
  final Category? category;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final next = Recurrence.nextDue(rule);
    final status = !rule.active
        ? 'En pausa'
        : next == null
        ? 'Finalizado'
        : 'Próximo: ${Formatters.dayMonth(next)}';
    final isIncome = rule.kind == MovementKind.income;

    return InkWell(
      onTap: () => showRecurringEditor(context, editing: rule),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.xs, AppSpacing.sm),
        child: Row(
          children: [
            Opacity(
              opacity: rule.active ? 1 : 0.5,
              child: CategoryAvatar(category: category),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(rule.name, style: context.text.titleSmall?.copyWith(fontSize: 15)),
                  const SizedBox(height: 2),
                  Text('${rule.frequency.label} · $status', style: context.text.bodySmall),
                ],
              ),
            ),
            Text(
              '${isIncome ? '+' : ''}${Formatters.money(rule.amountCents)}',
              style: AppTypography.amount(
                15,
                weight: FontWeight.w600,
                color: isIncome ? context.colors.income : context.scheme.onSurface,
              ).copyWith(letterSpacing: 0),
            ),
            Switch(value: rule.active, onChanged: onToggle),
          ],
        ),
      ),
    );
  }
}
