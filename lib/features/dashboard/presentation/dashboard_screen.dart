import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/domain/quincena.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/animated_amount.dart';
import '../../../core/widgets/async_reveal.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/pressable.dart';
import '../../../core/widgets/round_action.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/skeleton.dart';
import '../../cards/domain/card_summary.dart';
import '../../cards/presentation/card_payment_sheet.dart';
import '../../cards/presentation/card_providers.dart';
import '../../cards/presentation/widgets/card_panels.dart';
import '../../cards/presentation/widgets/credit_card_view.dart';
import '../../categories/domain/category.dart';
import '../../categories/presentation/category_providers.dart';
import '../../transactions/domain/movement.dart';
import '../../transactions/domain/period_summary.dart';
import '../../transactions/presentation/movement_providers.dart';
import '../../transactions/presentation/quick_add_sheet.dart';
import '../../transactions/presentation/widgets/movement_tile.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final quincena = Quincena.of(now);
    final summary = ref.watch(currentQuincenaMovementsProvider).whenData(PeriodSummary.of);
    final recent = ref.watch(recentMovementsProvider);
    final categories = ref.watch(categoriesByIdProvider).value ?? const <int, Category>{};
    final cards = ref.watch(cardSummariesProvider);

    final sections = <Widget>[
      _Header(now: now, quincena: quincena),
      AsyncReveal<PeriodSummary>(
        value: summary,
        skeleton: const _HeroSkeleton(),
        builder: (s) => _Hero(quincena: quincena, now: now, summary: s),
      ),
      _QuickActions(cards: cards.value ?? const []),
      AsyncReveal<PeriodSummary>(
        value: summary,
        skeleton: const _Padded(child: Skeleton(height: 120, radius: AppRadius.lg)),
        builder: (s) => _IncomeExpenseCard(summary: s),
      ),
      SectionHeader(
        title: 'Próximo pago',
        actionLabel: 'Tarjetas',
        onAction: () => context.go(AppRoutes.cards),
      ),
      AsyncReveal<List<CardSummary>>(
        value: cards,
        skeleton: const _Padded(child: Skeleton(height: 96, radius: AppRadius.lg)),
        builder: (list) => _NextPayment(summaries: list),
      ),
      SectionHeader(
        title: 'Últimos movimientos',
        actionLabel: 'Ver todos',
        onAction: () => context.go(AppRoutes.transactions),
      ),
      _Padded(
        child: Card(
          child: AsyncReveal<List<Movement>>(
            value: recent,
            skeleton: const SkeletonList(count: 3),
            builder: (list) => list.isEmpty
                ? SizedBox(
                    width: double.infinity,
                    child: EmptyState(
                      compact: true,
                      icon: Icons.receipt_long_rounded,
                      title: 'Aún no hay movimientos',
                      message: 'Registra tu primer gasto o ingreso en segundos.',
                      actionLabel: 'Agregar movimiento',
                      onAction: () => showQuickAddSheet(context),
                    ),
                  )
                : Column(
                    children: [
                      for (final m in list)
                        MovementTile(
                          key: ValueKey(m.id),
                          movement: m,
                          category: categories[m.categoryId],
                          onTap: () => showQuickAddSheet(context, editing: m),
                        ).animate().fadeIn(duration: AppDurations.medium).slideX(begin: 0.04),
                    ],
                  ),
          ),
        ),
      ),
      const SizedBox(height: AppSpacing.xl),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          children: sections
              .animate(interval: 50.ms)
              .fadeIn(duration: AppDurations.slow, curve: AppCurves.standard)
              .slideY(begin: 0.06, curve: AppCurves.standard),
        ),
      ),
    );
  }
}

class _Padded extends StatelessWidget {
  const _Padded({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
    child: child,
  );
}

class _Header extends StatelessWidget {
  const _Header({required this.now, required this.quincena});

  final DateTime now;
  final Quincena quincena;

  String get _greeting {
    final h = now.hour;
    if (h < 12) return 'Buenos días';
    if (h < 19) return 'Buenas tardes';
    return 'Buenas noches';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.sm, AppSpacing.page, 0),
      child: Row(
        children: [
          Pressable(
            semanticLabel: 'Más opciones',
            onTap: () => context.push(AppRoutes.more),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: context.scheme.primaryContainer, shape: BoxShape.circle),
              child: Icon(Icons.person_rounded, color: context.scheme.primary),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_greeting, style: context.text.titleMedium),
                Text(
                  Formatters.longDate(now),
                  style: context.text.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Pagos recurrentes',
            onPressed: () => context.push(AppRoutes.recurring),
            style: IconButton.styleFrom(backgroundColor: context.colors.surfaceHigh),
            icon: const Icon(Icons.autorenew_rounded, size: 22),
          ),
        ],
      ),
    );
  }
}

/// Saldo disponible de la quincena, en grande y sin contenedor.
class _Hero extends StatelessWidget {
  const _Hero({required this.quincena, required this.now, required this.summary});

  final Quincena quincena;
  final DateTime now;
  final PeriodSummary summary;

  @override
  Widget build(BuildContext context) {
    final available = summary.balanceCents;
    final daysLeft = quincena.daysLeft(now);
    final perDay = available > 0 && daysLeft > 0 ? available ~/ daysLeft : null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.xl, AppSpacing.page, AppSpacing.lg),
      child: Column(
        children: [
          Text('Disponible esta quincena', style: context.text.labelMedium),
          const SizedBox(height: AppSpacing.xs),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: AnimatedAmount(
              cents: available,
              smallCents: true,
              style: AppTypography.amount(
                54,
                color: available < 0 ? context.colors.expense : context.scheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              _Pill(icon: Icons.date_range_rounded, label: quincena.label),
              _Pill(
                icon: Icons.hourglass_bottom_rounded,
                label: daysLeft == 1 ? 'Último día' : '$daysLeft días restantes',
              ),
              if (perDay != null)
                _Pill(
                  icon: Icons.wb_sunny_outlined,
                  label: '${Formatters.moneyRounded(perDay)} al día',
                  highlighted: true,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label, this.highlighted = false});

  final IconData icon;
  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final color = highlighted ? context.scheme.primary : context.colors.textSecondary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: highlighted ? context.scheme.primaryContainer : context.colors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: context.text.labelMedium?.copyWith(color: highlighted ? context.scheme.onSurface : null),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.cards});

  final List<CardSummary> cards;

  @override
  Widget build(BuildContext context) {
    // "Pagar" abre el pago de la tarjeta más urgente.
    final dueFirst = [...cards]..sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundAction(
            icon: Icons.remove_rounded,
            label: 'Gasto',
            filled: true,
            onTap: () => showQuickAddSheet(context),
          ),
          RoundAction(
            icon: Icons.add_rounded,
            label: 'Ingreso',
            onTap: () => showQuickAddSheet(context, kind: MovementKind.income),
          ),
          RoundAction(
            icon: Icons.payments_rounded,
            label: 'Pagar',
            onTap: dueFirst.isEmpty
                ? () => context.go(AppRoutes.cards)
                : () => showCardPaymentSheet(context, dueFirst.first),
          ),
          RoundAction(
            icon: Icons.bar_chart_rounded,
            label: 'Análisis',
            onTap: () => context.go(AppRoutes.reports),
          ),
        ],
      ),
    );
  }
}

class _IncomeExpenseCard extends StatelessWidget {
  const _IncomeExpenseCard({required this.summary});

  final PeriodSummary summary;

  @override
  Widget build(BuildContext context) {
    final s = summary;
    final ratio = s.incomeCents == 0 ? null : s.expenseCents / s.incomeCents;

    Widget stat(String label, int cents, Color color, IconData icon) => Expanded(
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: context.text.labelMedium),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: AnimatedAmount(
                    cents: cents,
                    smallCents: true,
                    style: AppTypography.amount(18, weight: FontWeight.w600, color: context.scheme.onSurface),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.xl, AppSpacing.page, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  stat('Ingresos', s.incomeCents, context.colors.income, Icons.south_west_rounded),
                  const SizedBox(width: AppSpacing.sm),
                  stat('Gastos', s.expenseCents, context.colors.expense, Icons.north_east_rounded),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.pill),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: (ratio ?? 0).clamp(0.0, 1.0)),
                  duration: AppDurations.counter,
                  curve: AppCurves.emphasized,
                  builder: (_, v, _) => LinearProgressIndicator(
                    value: v,
                    minHeight: 6,
                    color: (ratio ?? 0) > 0.9 ? context.colors.expense : context.scheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                ratio == null
                    ? 'Registra tu ingreso de la quincena para ver cuánto llevas gastado.'
                    : 'Has gastado ${Formatters.percent(ratio)} de lo que ingresó esta quincena'
                          '${s.unexpectedCents > 0 ? ' · ${Formatters.moneyRounded(s.unexpectedCents)} en imprevistos' : ''}.',
                style: context.text.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pago de tarjeta más próximo, o una invitación a agregar una.
class _NextPayment extends StatelessWidget {
  const _NextPayment({required this.summaries});

  final List<CardSummary> summaries;

  @override
  Widget build(BuildContext context) {
    if (summaries.isEmpty) return _NoCardsPlaceholder(onTap: () => context.go(AppRoutes.cards));

    final due = summaries.where((s) => s.nextDueCents > 0).toList()
      ..sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));
    if (due.isEmpty) {
      return _Padded(
        child: Card(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
            leading: Icon(Icons.check_circle_rounded, color: context.colors.income, size: 32),
            title: const Text('Sin pagos pendientes'),
            subtitle: const Text('Tus tarjetas están al corriente.'),
            onTap: () => context.go(AppRoutes.cards),
          ),
        ),
      );
    }

    final s = due.first;
    final (color, label, icon) = paymentStatusStyle(context, s);
    final projected = s.nextIsCurrentCycle;

    return _Padded(
      child: Pressable(
        scale: 0.98,
        semanticLabel:
            '${projected ? 'Corte proyectado' : 'Pago'} de ${s.card.name}: ${Formatters.money(s.nextDueCents)}, '
            'fecha límite ${Formatters.date(s.nextDueDate)}',
        onTap: () => context.go(AppRoutes.cardDetail(s.card.id)),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                SizedBox(width: 76, child: CreditCardView(card: s.card, elevated: false)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.card.name,
                        style: context.text.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        projected
                            ? 'Corte proyectado · paga el ${Formatters.dayMonth(s.nextDueDate)}'
                            : 'Vence ${Formatters.relativeDays(s.nextDueDate, s.today)} · ${Formatters.dayMonth(s.nextDueDate)}',
                        style: context.text.bodySmall?.copyWith(color: projected ? null : color),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Formatters.money(s.nextDueCents),
                      style: AppTypography.amount(
                        16,
                        weight: FontWeight.w700,
                        color: context.scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (!projected) StatusChip(color: color, label: label),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Silueta de tarjeta de crédito mientras no hay tarjetas registradas.
class _NoCardsPlaceholder extends StatelessWidget {
  const _NoCardsPlaceholder({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _Padded(
      child: Pressable(
        semanticLabel: 'Agregar tarjeta de crédito',
        onTap: onTap,
        child: CustomPaint(
          painter: _DashedBorderPainter(color: context.scheme.outline, radius: AppRadius.lg),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: context.scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(Icons.add_card_rounded, color: context.scheme.primary),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Agrega una tarjeta', style: context.text.titleMedium),
                      const SizedBox(height: 2),
                      Text(
                        'Verás aquí tu corte proyectado y cuántos días faltan para pagar.',
                        style: context.text.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: context.colors.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final path = Path()..addRRect(RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)));
    const dash = 6.0;
    const gap = 5.0;
    for (final metric in path.computeMetrics()) {
      var d = 0.0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + dash), paint);
        d += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) => old.color != color || old.radius != radius;
}

class _HeroSkeleton extends StatelessWidget {
  const _HeroSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.xl, AppSpacing.page, AppSpacing.lg),
      child: Column(
        children: [
          Skeleton(width: 150, height: 14),
          SizedBox(height: AppSpacing.sm),
          Skeleton(width: 240, height: 52, radius: AppRadius.md),
          SizedBox(height: AppSpacing.md),
          Skeleton(width: 260, height: 28, radius: AppRadius.pill),
        ],
      ),
    );
  }
}
