import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/services/haptics.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/animated_amount.dart';
import '../../../core/widgets/async_reveal.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/feedback.dart';
import '../../../core/widgets/filter_pill.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sliding_segmented.dart';
import '../../../core/widgets/split_bar.dart';
import '../../categories/domain/category.dart';
import '../../categories/presentation/category_providers.dart';
import '../data/movement_repository.dart';
import '../domain/movement.dart';
import '../domain/period.dart';
import '../domain/period_summary.dart';
import 'movement_providers.dart';
import 'quick_add_sheet.dart';
import 'widgets/movement_tile.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  /// Ids que se acaban de deslizar para borrar: se ocultan de inmediato, antes
  /// de que la base confirme, para que el Dismissible no siga en el árbol.
  final _hidden = <int>{};

  Future<void> _delete(Movement m) async {
    setState(() => _hidden.add(m.id));
    final messenger = ScaffoldMessenger.of(context);
    final repo = ref.read(movementRepositoryProvider);
    final deleted = await repo.delete(m.id);
    if (deleted == null) return;
    showAppSnackBar(
      messenger,
      'Movimiento eliminado',
      onUndo: () async {
        await repo.restore(deleted);
        if (mounted) setState(() => _hidden.remove(m.id));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(movementsFilterProvider);
    final movements = ref.watch(movementsInRangeProvider(filter.period.range));
    final categories = ref.watch(categoriesByIdProvider).value ?? const <int, Category>{};

    return PageScaffold(
      title: 'Movimientos',
      slivers: [
        SliverToBoxAdapter(child: _PeriodBar(filter: filter)),
        SliverToBoxAdapter(child: _KindChips(selected: filter.kind)),
        SliverToBoxAdapter(
          child: AsyncReveal<List<Movement>>(
            value: movements,
            skeleton: const _ListSkeleton(),
            builder: (all) {
              final visible = all.where((m) => !_hidden.contains(m.id)).toList();
              final filtered = visible.where(filter.kind.matches).toList();
              return Column(
                children: [
                  _SummaryCard(summary: PeriodSummary.of(visible)),
                  if (filtered.isEmpty)
                    _EmptyForFilter(filter: filter)
                  else
                    _GroupedList(movements: filtered, categories: categories, onDelete: _delete),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PeriodBar extends ConsumerWidget {
  const _PeriodBar({required this.filter});

  final MovementsFilterState filter;

  Future<void> _pickRange(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();
    final current = filter.period.range;
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 1, 12, 31),
      initialDateRange: DateTimeRange(start: current.start, end: current.lastDay),
      helpText: 'Elige el rango',
      saveText: 'Aplicar',
    );
    if (picked == null) return;
    ref
        .read(movementsFilterProvider.notifier)
        .setPeriod(PeriodSelection.custom(DateRange.days(picked.start, picked.end)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(movementsFilterProvider.notifier);
    final period = filter.period;

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.xs, AppSpacing.page, 0),
      child: Column(
        children: [
          SlidingSegmented<PeriodType>(
            segments: [for (final t in PeriodType.values) Segment(t, t.label)],
            selected: period.type,
            onChanged: (t) {
              if (t == PeriodType.custom) {
                _pickRange(context, ref);
              } else {
                notifier.setType(t);
              }
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              _StepButton(
                icon: Icons.chevron_left_rounded,
                tooltip: 'Periodo anterior',
                onTap: period.canStep ? notifier.previous : null,
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: period.type == PeriodType.custom ? () => _pickRange(context, ref) : null,
                  child: AnimatedSwitcher(
                    duration: AppDurations.medium,
                    transitionBuilder: (child, a) => FadeTransition(
                      opacity: a,
                      child: SlideTransition(
                        position: Tween(begin: const Offset(0, 0.25), end: Offset.zero).animate(a),
                        child: child,
                      ),
                    ),
                    child: Text(
                      period.label,
                      key: ValueKey(period),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.titleMedium,
                    ),
                  ),
                ),
              ),
              _StepButton(
                icon: Icons.chevron_right_rounded,
                tooltip: 'Periodo siguiente',
                onTap: period.canStep ? notifier.next : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.tooltip, required this.onTap});

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onTap == null
          ? null
          : () {
              Haptics.tap();
              onTap!();
            },
      style: IconButton.styleFrom(
        backgroundColor: context.colors.surfaceHigh,
        fixedSize: const Size(40, 40),
        minimumSize: const Size(40, 40),
      ),
      icon: Icon(icon, size: 22),
    );
  }
}

class _KindChips extends ConsumerWidget {
  const _KindChips({required this.selected});

  final KindFilter selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.xs, AppSpacing.page, AppSpacing.xs),
        scrollDirection: Axis.horizontal,
        itemCount: KindFilter.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
        itemBuilder: (context, i) {
          final k = KindFilter.values[i];
          return FilterPill(
            label: k.label,
            selected: k == selected,
            onTap: () => ref.read(movementsFilterProvider.notifier).setKind(k),
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summary});

  final PeriodSummary summary;

  @override
  Widget build(BuildContext context) {
    final balance = summary.balanceCents;

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.xs, AppSpacing.page, AppSpacing.xs),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Balance del periodo', style: context.text.labelMedium),
              const SizedBox(height: 6),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: AnimatedAmount(
                  cents: balance,
                  smallCents: true,
                  style: AppTypography.amount(
                    34,
                    color: balance < 0 ? context.colors.expense : context.scheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SplitBar(
                values: [summary.incomeCents, summary.expenseCents],
                colors: [context.colors.income, context.colors.expense],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _Stat(label: 'Ingresos', cents: summary.incomeCents, color: context.colors.income),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _Stat(label: 'Gastos', cents: summary.expenseCents, color: context.colors.expense),
                  ),
                ],
              ),
              if (summary.unexpectedCents > 0) ...[
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: context.colors.warning.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.bolt_rounded, size: 16, color: context.colors.warning),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Imprevistos',
                          style: context.text.labelMedium?.copyWith(color: context.colors.warning),
                        ),
                      ),
                      Text(
                        Formatters.money(summary.unexpectedCents),
                        style: AppTypography.amount(
                          14,
                          color: context.colors.warning,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.cents, required this.color});

  final String label;
  final int cents;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(label, style: context.text.labelMedium),
          ],
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: AnimatedAmount(
            cents: cents,
            smallCents: true,
            style: AppTypography.amount(19, weight: FontWeight.w600, color: context.scheme.onSurface),
          ),
        ),
      ],
    );
  }
}

class _GroupedList extends StatelessWidget {
  const _GroupedList({required this.movements, required this.categories, required this.onDelete});

  final List<Movement> movements;
  final Map<int, Category> categories;
  final ValueChanged<Movement> onDelete;

  static String _dayLabel(DateTime day) {
    final today = DateUtils.dateOnly(DateTime.now());
    if (day == today) return 'Hoy';
    if (day == today.subtract(const Duration(days: 1))) return 'Ayer';
    final label = DateFormat("EEEE d 'de' MMMM", 'es_MX').format(day);
    return '${label[0].toUpperCase()}${label.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    final groups = groupBy(movements, (Movement m) => DateUtils.dateOnly(m.date));
    var index = 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final entry in groups.entries) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xxs,
                AppSpacing.md,
                AppSpacing.xxs,
                AppSpacing.xs,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(_dayLabel(entry.key), style: context.text.titleSmall),
                    ),
                  ),
                  Text(
                    Formatters.moneySigned(entry.value.fold(0, (sum, m) => sum + m.signedCents)),
                    style: AppTypography.amount(
                      13,
                      color: context.colors.textSecondary,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  for (final m in entry.value)
                    _DismissibleMovement(
                      key: ValueKey(m.id),
                      movement: m,
                      category: categories[m.categoryId],
                      onDelete: onDelete,
                    ).animate().fadeIn(delay: (30 * index++).clamp(0, 360).ms, duration: AppDurations.medium),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DismissibleMovement extends StatelessWidget {
  const _DismissibleMovement({
    required this.movement,
    required this.category,
    required this.onDelete,
    super.key,
  });

  final Movement movement;
  final Category? category;
  final ValueChanged<Movement> onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('dismiss-${movement.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: context.colors.expense,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Eliminar',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: AppSpacing.xs),
            Icon(Icons.delete_outline_rounded, color: Colors.white),
          ],
        ),
      ),
      confirmDismiss: (_) => showConfirmDialog(
        context,
        title: '¿Eliminar este movimiento?',
        message: 'Podrás deshacerlo durante unos segundos.',
      ),
      onDismissed: (_) => onDelete(movement),
      child: MovementTile(
        movement: movement,
        category: category,
        onTap: () => showQuickAddSheet(context, editing: movement),
      ),
    );
  }
}

class _EmptyForFilter extends StatelessWidget {
  const _EmptyForFilter({required this.filter});

  final MovementsFilterState filter;

  @override
  Widget build(BuildContext context) {
    final (title, message) = switch (filter.kind) {
      KindFilter.all => (
        'Sin movimientos en este periodo',
        'Registra un gasto o ingreso, o cambia el periodo.',
      ),
      KindFilter.expenses => ('Sin gastos en este periodo', '¡Bien! O quizá aún no los registras.'),
      KindFilter.incomes => ('Sin ingresos en este periodo', 'Registra tu quincena o un ingreso extra.'),
      KindFilter.unexpected => (
        'Sin imprevistos',
        'Al registrar un gasto, marca "Imprevisto" para verlo aquí.',
      ),
    };
    return EmptyState(
      icon: filter.kind == KindFilter.unexpected ? Icons.bolt_rounded : Icons.receipt_long_rounded,
      title: title,
      message: message,
      actionLabel: filter.kind == KindFilter.unexpected ? null : 'Agregar movimiento',
      onAction: () => showQuickAddSheet(
        context,
        kind: filter.kind == KindFilter.incomes ? MovementKind.income : MovementKind.expense,
      ),
    );
  }
}

class _ListSkeleton extends StatelessWidget {
  const _ListSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xs),
          const Skeleton(height: 168, radius: AppRadius.lg),
          const SizedBox(height: AppSpacing.lg),
          const Skeleton(width: 120, height: 14),
          const SizedBox(height: AppSpacing.sm),
          Card(child: const SkeletonList(count: 3).animate().fadeIn()),
          const SizedBox(height: AppSpacing.lg),
          const Skeleton(width: 90, height: 14),
          const SizedBox(height: AppSpacing.sm),
          const Card(child: SkeletonList(count: 2)),
        ],
      ),
    );
  }
}
