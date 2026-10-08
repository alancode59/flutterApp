import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../core/services/haptics.dart';
import '../../../core/widgets/async_reveal.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/pressable.dart';
import '../../../core/widgets/round_action.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/skeleton.dart';
import '../../categories/domain/category.dart';
import '../../categories/presentation/category_providers.dart';
import '../../transactions/domain/movement.dart';
import '../../transactions/presentation/quick_add_sheet.dart';
import '../../transactions/presentation/widgets/movement_tile.dart';
import '../domain/card_summary.dart';
import '../domain/credit_card.dart';
import '../domain/installment_plan.dart';
import 'bank_balance_sheet.dart';
import 'card_editor_sheet.dart';
import 'card_payment_sheet.dart';
import 'card_providers.dart';
import 'installment_plan_sheet.dart';
import 'widgets/card_panels.dart';
import 'widgets/credit_card_view.dart';

String cardHeroTag(int id) => 'card-$id';

/// Abre la compra con la tarjeta, o el plan MSI si es una mensualidad.
void openCharge(BuildContext context, Movement m) {
  if (m.isInstallment) {
    showInstallmentPlanSheet(context, m.installmentPlanId!);
  } else {
    showQuickAddSheet(context, editing: m);
  }
}

class CardsScreen extends ConsumerStatefulWidget {
  const CardsScreen({super.key});

  @override
  ConsumerState<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends ConsumerState<CardsScreen> {
  final _pager = PageController(viewportFraction: 0.86);
  int _page = 0;

  @override
  void dispose() {
    _pager.dispose();
    super.dispose();
  }

  Future<void> _addCard() async {
    final id = await showCardEditor(context);
    if (id == null || !mounted) return;
    // Lleva el carrusel a la tarjeta nueva cuando aparezca.
    final cards = await ref.read(activeCardsProvider.future);
    final index = cards.indexWhere((c) => c.id == id);
    if (index >= 0 && _pager.hasClients) {
      await _pager.animateToPage(index, duration: AppDurations.slow, curve: AppCurves.emphasized);
    }
  }

  @override
  Widget build(BuildContext context) {
    final summaries = ref.watch(cardSummariesProvider);

    return PageScaffold(
      title: 'Tarjetas',
      actions: [
        IconButton(
          tooltip: 'Agregar tarjeta',
          onPressed: _addCard,
          style: IconButton.styleFrom(backgroundColor: context.colors.surfaceHigh),
          icon: const Icon(Icons.add_rounded),
        ),
      ],
      slivers: [
        SliverToBoxAdapter(
          child: AsyncReveal<List<CardSummary>>(
            value: summaries,
            skeleton: const _CardsSkeleton(),
            builder: (list) {
              if (list.isEmpty) {
                return EmptyState(
                  icon: Icons.credit_card_rounded,
                  title: 'Agrega tu primera tarjeta',
                  message: 'Registra tus compras y ve de cuánto será tu corte, cuándo pagar, tus MSI y cuánto crédito usas.',
                  actionLabel: 'Agregar tarjeta',
                  onAction: _addCard,
                );
              }
              final page = _page.clamp(0, list.length);
              final selected = page < list.length ? list[page] : null;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Carousel(
                    controller: _pager,
                    summaries: list,
                    onPage: (i) {
                      Haptics.light();
                      setState(() => _page = i);
                    },
                    onAdd: _addCard,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _Dots(count: list.length + 1, index: page),
                  const SizedBox(height: AppSpacing.sm),
                  AnimatedSwitcher(
                    duration: AppDurations.slow,
                    switchInCurve: AppCurves.standard,
                    transitionBuilder: (child, a) => FadeTransition(
                      opacity: a,
                      child: SlideTransition(
                        position: Tween(begin: const Offset(0, 0.03), end: Offset.zero).animate(a),
                        child: child,
                      ),
                    ),
                    layoutBuilder: (current, previous) =>
                        Stack(alignment: Alignment.topCenter, children: [...previous, ?current]),
                    child: selected == null
                        ? _AddCardHint(key: const ValueKey('add'), onAdd: _addCard)
                        : _CardOverview(key: ValueKey(selected.card.id), summary: selected),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Carousel extends StatelessWidget {
  const _Carousel({
    required this.controller,
    required this.summaries,
    required this.onPage,
    required this.onAdd,
  });

  final PageController controller;
  final List<CardSummary> summaries;
  final ValueChanged<int> onPage;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final cardWidth = math.min(width * 0.86, 420.0) - AppSpacing.md;
    final height = cardWidth / kCardAspectRatio + 36;

    return SizedBox(
      height: height,
      child: PageView.builder(
        controller: controller,
        onPageChanged: onPage,
        itemCount: summaries.length + 1,
        itemBuilder: (context, i) => AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final page = controller.hasClients && controller.position.haveDimensions
                ? controller.page ?? controller.initialPage.toDouble()
                : controller.initialPage.toDouble();
            final delta = (page - i).abs().clamp(0.0, 1.0);
            return Transform.scale(
              scale: 1 - 0.08 * delta,
              child: Opacity(opacity: 1 - 0.45 * delta, child: child),
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.xs, AppSpacing.xs, AppSpacing.xs, 28),
            child: Center(
              child: i == summaries.length
                  ? _AddCardTile(onTap: onAdd)
                  : Pressable(
                      scale: 0.97,
                      semanticLabel: 'Ver detalle de ${summaries[i].card.name}',
                      onTap: () => context.push(AppRoutes.cardDetail(summaries[i].card.id)),
                      child: CreditCardView(
                        card: summaries[i].card,
                        heroTag: cardHeroTag(summaries[i].card.id),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddCardTile extends StatelessWidget {
  const _AddCardTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      semanticLabel: 'Agregar tarjeta',
      child: AspectRatio(
        aspectRatio: kCardAspectRatio,
        child: Container(
          decoration: BoxDecoration(
            color: context.scheme.surfaceContainer,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: context.scheme.outline, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(color: context.scheme.primaryContainer, shape: BoxShape.circle),
                child: Icon(Icons.add_rounded, color: context.scheme.primary, size: 28),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text('Agregar tarjeta', style: context.text.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++)
            AnimatedContainer(
              duration: AppDurations.medium,
              curve: AppCurves.emphasized,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == index ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: i == index ? context.scheme.primary : context.scheme.outline,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddCardHint extends StatelessWidget {
  const _AddCardHint({required this.onAdd, super.key});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.page),
      child: Text(
        'Agrega otra tarjeta para llevar sus cortes y pagos por separado.',
        textAlign: TextAlign.center,
        style: context.text.bodyMedium?.copyWith(color: context.colors.textSecondary),
      ),
    );
  }
}

/// Resumen de la tarjeta seleccionada en el carrusel.
class _CardOverview extends ConsumerWidget {
  const _CardOverview({required this.summary, super.key});

  final CardSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = summary;
    final card = s.card;
    final charges = (ref.watch(creditChargesProvider).value ?? const <Movement>[])
        .where((m) => m.cardId == card.id && s.currentCycle.contains(m.date))
        .toList();
    final plans = (ref.watch(installmentPlansProvider).value ?? const <InstallmentPlan>[])
        .where((p) => p.cardId == card.id && p.billedCount(s.today) < p.months)
        .toList();
    final categories = ref.watch(categoriesByIdProvider).value ?? const <int, Category>{};

    final sections = <Widget>[
      _QuickActions(card: card, summary: s),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
        child: NextPaymentPanel(
          summary: s,
          onPay: () => showCardPaymentSheet(context, s),
          onSync: () => showBankBalanceSheet(context, s),
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
        child: ProjectedPanel(summary: s),
      ),
      const SizedBox(height: AppSpacing.sm),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
        child: CreditLinePanel(summary: s, onSync: () => showBankBalanceSheet(context, s)),
      ),
      if (plans.isNotEmpty) ...[
        const SectionHeader(title: 'Meses sin intereses'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
          child: Card(
            child: Column(
              children: [
                for (final p in plans)
                  InstallmentPlanTile(
                    plan: p,
                    today: s.today,
                    onTap: () => showInstallmentPlanSheet(context, p.id),
                  ),
              ],
            ),
          ),
        ),
      ],
      SectionHeader(
        title: 'Compras del periodo',
        actionLabel: 'Ver todo',
        onAction: () => context.push(AppRoutes.cardDetail(card.id)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
        child: Card(
          child: charges.isEmpty
              ? EmptyState(
                  compact: true,
                  icon: Icons.shopping_bag_outlined,
                  title: 'Sin compras en este periodo',
                  message: 'Registra lo que pagas con ${card.name} para proyectar tu corte.',
                  actionLabel: 'Registrar compra',
                  onAction: () => showQuickAddSheet(context, cardId: card.id),
                )
              : Column(
                  children: [
                    for (final m in charges.take(6))
                      MovementTile(
                        key: ValueKey(m.id),
                        movement: m,
                        category: categories[m.categoryId],
                        onTap: () => openCharge(context, m),
                      ),
                  ],
                ),
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: sections
          .animate(interval: 40.ms)
          .fadeIn(duration: AppDurations.medium)
          .slideY(begin: 0.05, curve: AppCurves.standard),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.card, required this.summary});

  final CreditCard card;
  final CardSummary summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.xs, AppSpacing.page, AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundAction(
            icon: Icons.add_shopping_cart_rounded,
            label: 'Compra',
            onTap: () => showQuickAddSheet(context, cardId: card.id),
          ),
          RoundAction(
            icon: Icons.payments_rounded,
            label: 'Pagar',
            onTap: () => showCardPaymentSheet(context, summary),
          ),
          RoundAction(
            icon: Icons.receipt_long_rounded,
            label: 'Detalle',
            onTap: () => context.push(AppRoutes.cardDetail(card.id)),
          ),
          RoundAction(
            icon: Icons.tune_rounded,
            label: 'Editar',
            onTap: () => showCardEditor(context, editing: card),
          ),
        ],
      ),
    );
  }
}

class _CardsSkeleton extends StatelessWidget {
  const _CardsSkeleton();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final cardWidth = math.min(width * 0.86, 420.0) - AppSpacing.md;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xs),
          Skeleton(width: cardWidth, height: cardWidth / kCardAspectRatio, radius: 22),
          const SizedBox(height: AppSpacing.xxl + AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [for (var i = 0; i < 4; i++) const Skeleton(width: 52, height: 52, radius: 26)],
          ),
          const SizedBox(height: AppSpacing.xl),
          const Skeleton(height: 190, radius: AppRadius.lg),
          const SizedBox(height: AppSpacing.sm),
          const Skeleton(height: 150, radius: AppRadius.lg),
        ],
      ),
    );
  }
}
