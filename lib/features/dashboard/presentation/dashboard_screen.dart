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
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/skeleton.dart';
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

    final sections = <Widget>[
      _Header(now: now),
      AsyncReveal<PeriodSummary>(
        value: summary,
        skeleton: const _Padded(child: Skeleton(height: 214, radius: AppRadius.lg)),
        builder: (s) => _BalanceCard(quincena: quincena, now: now, summary: s),
      ),
      const _PrimaryActions(),
      SectionHeader(
        title: 'Próximo pago',
        actionLabel: 'Tarjetas',
        onAction: () => context.go(AppRoutes.cards),
      ),
      _NextPaymentPlaceholder(onTap: () => context.go(AppRoutes.cards)),
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
      const SizedBox(height: AppSpacing.xxl),
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
  const _Header({required this.now});

  final DateTime now;

  String get _greeting {
    final h = now.hour;
    if (h < 12) return 'Buenos días';
    if (h < 19) return 'Buenas tardes';
    return 'Buenas noches';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.sm, AppSpacing.page - 4, AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_greeting, style: context.text.headlineSmall),
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
            tooltip: 'Más opciones',
            onPressed: () => context.push(AppRoutes.more),
            style: IconButton.styleFrom(backgroundColor: context.scheme.surfaceContainer),
            icon: const Icon(Icons.person_rounded),
          ),
        ],
      ),
    );
  }
}

/// Saldo disponible de la quincena con la barra de gastado contra el límite.
/// Los montos se conectan a datos reales en las fases 2 (movimientos) y 5 (presupuesto).
class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.quincena, required this.now, required this.summary});

  final Quincena quincena;
  final DateTime now;
  final PeriodSummary summary;

  @override
  Widget build(BuildContext context) {
    final available = summary.balanceCents;
    final spent = summary.expenseCents;
    // El límite de presupuesto llega en la Fase 5.
    const int? limit = null;
    final progress = limit == null || limit == 0 ? 0.0 : (spent / limit).clamp(0.0, 1.0);
    final daysLeft = quincena.daysLeft(now);
    final secondary = context.text.labelMedium;

    return _Padded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text('Te queda esta quincena', style: secondary)),
                  Text(quincena.label, style: secondary),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: AnimatedAmount(
                  cents: available,
                  style: AppTypography.amount(
                    44,
                    color: available < 0 ? context.colors.expense : context.scheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Semantics(
                label: 'Presupuesto usado ${Formatters.percent(progress)}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress),
                    duration: AppDurations.counter,
                    curve: AppCurves.emphasized,
                    builder: (_, v, _) => LinearProgressIndicator(value: v, minHeight: 8),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(child: Text('Gastado ${Formatters.moneyRounded(spent)}', style: secondary)),
                  Text(
                    limit == null ? 'Sin límite definido' : 'Límite ${Formatters.moneyRounded(limit)}',
                    style: secondary,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  _Pill(
                    icon: Icons.hourglass_bottom_rounded,
                    label: daysLeft == 1 ? 'Último día de la quincena' : '$daysLeft días restantes',
                  ),
                  if (summary.incomeCents > 0)
                    _Pill(
                      icon: Icons.south_west_rounded,
                      label: 'Ingresos ${Formatters.moneyRounded(summary.incomeCents)}',
                    ),
                  if (summary.unexpectedCents > 0)
                    _Pill(
                      icon: Icons.bolt_rounded,
                      label: 'Imprevistos ${Formatters.moneyRounded(summary.unexpectedCents)}',
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 6),
      decoration: BoxDecoration(
        color: context.colors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: context.scheme.primary),
          const SizedBox(width: 6),
          Text(label, style: context.text.labelMedium),
        ],
      ),
    );
  }
}

class _PrimaryActions extends StatelessWidget {
  const _PrimaryActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.sm, AppSpacing.page, 0),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              icon: Icons.add_rounded,
              label: 'Gasto',
              filled: true,
              onTap: () => showQuickAddSheet(context),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _ActionButton(
              icon: Icons.south_west_rounded,
              label: 'Ingreso',
              onTap: () => showQuickAddSheet(context, kind: MovementKind.income),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label, required this.onTap, this.filled = false});

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final bg = filled ? context.scheme.primary : context.scheme.surfaceContainer;
    final fg = filled ? context.scheme.onPrimary : context.scheme.onSurface;

    return Pressable(
      semanticLabel: 'Agregar $label'.toLowerCase(),
      scale: 0.95,
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(AppRadius.md)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: fg, size: 20),
            const SizedBox(width: AppSpacing.xs),
            Text(label, style: context.text.labelLarge?.copyWith(color: fg)),
          ],
        ),
      ),
    );
  }
}

/// Silueta de tarjeta de crédito mientras no hay tarjetas registradas.
class _NextPaymentPlaceholder extends StatelessWidget {
  const _NextPaymentPlaceholder({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _Padded(
      child: Pressable(
        semanticLabel: 'Agregar tarjeta de crédito',
        onTap: onTap,
        child: CustomPaint(
          painter: _DashedBorderPainter(color: context.scheme.outline, radius: AppRadius.lg),
          child: SizedBox(
            height: 112,
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
