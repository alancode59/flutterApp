import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/services/haptics.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/feedback.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/section_header.dart';
import '../../categories/domain/category.dart';
import '../../categories/presentation/category_providers.dart';
import '../../transactions/domain/movement.dart';
import '../../transactions/presentation/widgets/movement_tile.dart';
import '../data/card_repository.dart';
import '../domain/billing_cycle.dart';
import '../domain/card_payment.dart';
import '../domain/card_summary.dart';
import '../domain/installment_plan.dart';
import 'bank_balance_sheet.dart';
import 'card_editor_sheet.dart';
import 'card_payment_sheet.dart';
import 'card_providers.dart';
import 'cards_screen.dart';
import 'installment_plan_sheet.dart';
import 'widgets/card_panels.dart';
import 'widgets/credit_card_view.dart';

class CardDetailScreen extends ConsumerStatefulWidget {
  const CardDetailScreen({required this.cardId, super.key});

  final int cardId;

  @override
  ConsumerState<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends ConsumerState<CardDetailScreen> {
  /// 0 = periodo actual, -1 = el anterior, etc.
  int _offset = 0;

  @override
  Widget build(BuildContext context) {
    final summary = ref
        .watch(cardSummariesProvider)
        .value
        ?.firstWhereOrNull((s) => s.card.id == widget.cardId);
    final card = summary?.card ?? ref.watch(cardsByIdProvider).value?[widget.cardId];

    if (card == null || summary == null) {
      // Archivada o recién borrada: regresa a la lista.
      return PageScaffold(
        title: card?.name ?? 'Tarjeta',
        slivers: const [
          SliverToBoxAdapter(
            child: EmptyState(
              icon: Icons.credit_card_off_rounded,
              title: 'Esta tarjeta ya no está activa',
              message: 'Puede que la hayas archivado. Tu historial se conserva en Movimientos.',
            ),
          ),
        ],
      );
    }

    var cycle = summary.currentCycle;
    for (var i = 0; i > _offset; i--) {
      cycle = cycle.previous;
    }
    final charges = (ref.watch(creditChargesProvider).value ?? const <Movement>[])
        .where((m) => m.cardId == card.id)
        .toList();
    final payments = (ref.watch(cardPaymentsProvider).value ?? const <CardPayment>[])
        .where((p) => p.cardId == card.id)
        .toList();
    final plans = (ref.watch(installmentPlansProvider).value ?? const <InstallmentPlan>[])
        .where((p) => p.cardId == card.id)
        .toList();
    final categories = ref.watch(categoriesByIdProvider).value ?? const <int, Category>{};
    final oldest = charges.map((m) => m.date).followedBy(payments.map((p) => p.date)).minOrNull;
    final canGoBack = oldest != null && oldest.isBefore(cycle.start);

    return PageScaffold(
      title: card.name,
      actions: [
        IconButton(
          tooltip: 'Editar tarjeta',
          onPressed: () => showCardEditor(context, editing: card),
          icon: const Icon(Icons.edit_outlined),
        ),
      ],
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.page * 2, AppSpacing.xs, AppSpacing.page * 2, 0),
            child: CreditCardView(card: card, heroTag: cardHeroTag(card.id)),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.lg, AppSpacing.page, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NextPaymentPanel(
                  summary: summary,
                  onPay: () => showCardPaymentSheet(context, summary),
                  onSync: () => showBankBalanceSheet(context, summary),
                ),
                const SizedBox(height: AppSpacing.sm),
                CreditLinePanel(summary: summary, onSync: () => showBankBalanceSheet(context, summary)),
              ],
            ).animate().fadeIn(delay: 150.ms, duration: AppDurations.slow).slideY(begin: 0.04),
          ),
        ),
        SliverToBoxAdapter(
          child: _CycleSection(
            summary: summary,
            cycle: cycle,
            offset: _offset,
            canGoBack: canGoBack,
            onStep: (delta) {
              Haptics.tap();
              setState(() => _offset += delta);
            },
            charges: charges.where((m) => cycle.contains(m.date)).toList(),
            payments: payments.where((p) => cycle.contains(p.date)).toList(),
            categories: categories,
          ),
        ),
        if (plans.isNotEmpty) ...[
          const SliverToBoxAdapter(child: SectionHeader(title: 'Meses sin intereses')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
              child: Card(
                child: Column(
                  children: [
                    for (final p in plans)
                      InstallmentPlanTile(
                        plan: p,
                        today: summary.today,
                        onTap: () => showInstallmentPlanSheet(context, p.id),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
        const SliverToBoxAdapter(child: SectionHeader(title: 'Datos de la tarjeta')),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
            child: Panel(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
              child: Column(
                children: [
                  _InfoRow(label: 'Banco', value: card.bank ?? '—'),
                  _InfoRow(label: 'Red', value: card.network.label),
                  _InfoRow(label: 'Límite de crédito', value: Formatters.money(card.limitCents)),
                  _InfoRow(label: 'Día de corte', value: 'Día ${card.cutoffDay} de cada mes'),
                  _InfoRow(label: 'Fecha límite de pago', value: 'Día ${card.dueDay}'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CycleSection extends ConsumerWidget {
  const _CycleSection({
    required this.summary,
    required this.cycle,
    required this.offset,
    required this.canGoBack,
    required this.onStep,
    required this.charges,
    required this.payments,
    required this.categories,
  });

  final CardSummary summary;
  final BillingCycle cycle;
  final int offset;
  final bool canGoBack;
  final ValueChanged<int> onStep;
  final List<Movement> charges;
  final List<CardPayment> payments;
  final Map<int, Category> categories;

  Future<void> _deletePayment(BuildContext context, WidgetRef ref, CardPayment p) async {
    final ok = await showConfirmDialog(
      context,
      title: '¿Eliminar este pago?',
      message: 'Podrás deshacerlo durante unos segundos.',
    );
    if (!ok || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final repo = ref.read(cardRepositoryProvider);
    final deleted = await repo.deletePayment(p.id);
    if (deleted != null) {
      showAppSnackBar(messenger, 'Pago eliminado', onUndo: () => repo.restorePayment(deleted));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chargedCents = charges.fold(0, (a, m) => a + m.amountCents);
    final paidCents = payments.fold(0, (a, p) => a + p.amountCents);
    final entries = <(DateTime, Widget)>[
      for (final m in charges)
        (
          m.date,
          MovementTile(
            key: ValueKey('m${m.id}'),
            movement: m,
            category: categories[m.categoryId],
            onTap: () => openCharge(context, m),
          ),
        ),
      for (final p in payments)
        (
          p.date,
          _PaymentTile(
            key: ValueKey('p${p.id}'),
            payment: p,
            onDelete: () => _deletePayment(context, ref, p),
          ),
        ),
    ]..sort((a, b) => b.$1.compareTo(a.$1));

    final title = switch (offset) {
      0 => 'Periodo actual',
      -1 => 'Último corte',
      _ => 'Corte del ${Formatters.dayMonth(cycle.cutoff)}',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.xl, AppSpacing.page, AppSpacing.xs),
          child: Row(
            children: [
              IconButton(
                tooltip: 'Corte anterior',
                onPressed: canGoBack ? () => onStep(-1) : null,
                style: IconButton.styleFrom(backgroundColor: context.colors.surfaceHigh),
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: AppDurations.medium,
                  child: Column(
                    key: ValueKey(cycle),
                    children: [
                      Text(title, style: context.text.titleMedium),
                      Text(cycle.label, style: context.text.bodySmall),
                    ],
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Corte siguiente',
                onPressed: offset < 0 ? () => onStep(1) : null,
                style: IconButton.styleFrom(backgroundColor: context.colors.surfaceHigh),
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _Total(label: 'Cargos', cents: chargedCents),
                      ),
                      Expanded(
                        child: _Total(label: 'Pagos', cents: paidCents, color: context.colors.income),
                      ),
                      Expanded(
                        child: _Total(
                          label: offset == 0 ? 'Corta' : 'Pagar antes de',
                          text: Formatters.dayMonth(offset == 0 ? cycle.cutoff : cycle.dueDate),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(indent: AppSpacing.md, endIndent: AppSpacing.md),
                AnimatedSwitcher(
                  duration: AppDurations.medium,
                  child: entries.isEmpty
                      ? Padding(
                          key: ValueKey('empty$offset'),
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          child: Text(
                            'Sin movimientos en este periodo.',
                            textAlign: TextAlign.center,
                            style: context.text.bodyMedium?.copyWith(color: context.colors.textSecondary),
                          ),
                        )
                      : Column(key: ValueKey('list$offset'), children: [for (final e in entries) e.$2]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Total extends StatelessWidget {
  const _Total({required this.label, this.cents, this.text, this.color});

  final String label;
  final int? cents;
  final String? text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.text.labelSmall),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            text ?? Formatters.money(cents!),
            style: AppTypography.amount(
              16,
              weight: FontWeight.w600,
              color: color ?? context.scheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({required this.payment, required this.onDelete, super.key});

  final CardPayment payment;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          'Pago a la tarjeta de ${Formatters.money(payment.amountCents)}, ${Formatters.date(payment.date)}',
      excludeSemantics: true,
      child: InkWell(
        onLongPress: onDelete,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.xxs, AppSpacing.sm),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: context.colors.income.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.payments_rounded, color: context.colors.income, size: 22),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pago a la tarjeta', style: context.text.titleSmall?.copyWith(fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(Formatters.date(payment.date), style: context.text.bodySmall),
                  ],
                ),
              ),
              Text(
                '+${Formatters.money(payment.amountCents)}',
                style: AppTypography.amount(15, weight: FontWeight.w600, color: context.colors.income),
              ),
              IconButton(
                tooltip: 'Eliminar pago',
                onPressed: onDelete,
                icon: Icon(Icons.close_rounded, size: 18, color: context.colors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: context.text.bodyMedium?.copyWith(color: context.colors.textSecondary)),
          ),
          Text(value, style: context.text.titleSmall),
        ],
      ),
    );
  }
}
