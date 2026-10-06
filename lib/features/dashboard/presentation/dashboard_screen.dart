import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/domain/quincena.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/animated_amount.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/pressable.dart';
import '../../../core/widgets/section_header.dart';
import '../../transactions/presentation/quick_add_sheet.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final quincena = Quincena.of(now);

    final sections = <Widget>[
      _Header(now: now),
      _BalanceCard(quincena: quincena, now: now),
      const _QuickActions(),
      SectionHeader(
        title: 'Próximos pagos',
        actionLabel: 'Tarjetas',
        onAction: () => context.go(AppRoutes.cards),
      ),
      _DashboardCard(
        child: EmptyState(
          compact: true,
          icon: Icons.credit_card_rounded,
          title: 'Sin tarjetas registradas',
          message: 'Agrega tus tarjetas para ver fechas de corte y pago.',
          actionLabel: 'Agregar tarjeta',
          onAction: () => context.go(AppRoutes.cards),
        ),
      ),
      const SectionHeader(title: 'Últimos movimientos'),
      _DashboardCard(
        child: EmptyState(
          compact: true,
          icon: Icons.receipt_long_rounded,
          title: 'Aún no hay movimientos',
          message: 'Registra tu primer gasto o ingreso en segundos.',
          actionLabel: 'Agregar movimiento',
          onAction: () => showQuickAddSheet(context),
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
      padding: const EdgeInsets.fromLTRB(AppSpacing.page - 4, AppSpacing.xs, AppSpacing.page, 0),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Más opciones',
            onPressed: () => context.push(AppRoutes.more),
            style: IconButton.styleFrom(backgroundColor: context.colors.surfaceHigh),
            icon: const Icon(Icons.person_rounded),
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
        ],
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.quincena, required this.now});

  final Quincena quincena;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final daysLeft = quincena.daysLeft(now);
    // Avance del periodo; en la Fase 5 se agrega el avance del presupuesto.
    final elapsed = 1 - (daysLeft - 1) / quincena.lengthInDays;

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.page, AppSpacing.xl, AppSpacing.page, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Disponible esta quincena', style: context.text.labelMedium),
          const SizedBox(height: AppSpacing.xs),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: AnimatedAmount(cents: 0, style: AppTypography.amount(48, color: context.scheme.onSurface)),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              _Pill(icon: Icons.calendar_today_rounded, label: quincena.label),
              _Pill(
                icon: Icons.hourglass_bottom_rounded,
                label: daysLeft == 1 ? 'Último día' : '$daysLeft días restantes',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Semantics(
            label: 'Avance de la quincena ${Formatters.percent(elapsed)}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: elapsed),
                duration: AppDurations.counter,
                curve: AppCurves.emphasized,
                builder: (_, v, _) => LinearProgressIndicator(value: v, minHeight: 6),
              ),
            ),
          ),
        ],
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
          Icon(icon, size: 14, color: context.colors.textSecondary),
          const SizedBox(width: 6),
          Text(label, style: context.text.labelMedium),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    void soon(String what) => ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$what estará disponible pronto.')));

    final actions = [
      (Icons.add_rounded, 'Agregar', () => showQuickAddSheet(context)),
      (Icons.credit_score_rounded, 'Pagar tarjeta', () => soon('Pagar tarjeta')),
      (Icons.pie_chart_rounded, 'Presupuesto', () => soon('Presupuesto')),
      (Icons.more_horiz_rounded, 'Más', () => context.push(AppRoutes.more)),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.xl, AppSpacing.md, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (icon, label, onTap) in actions)
            Expanded(
              child: _QuickAction(icon: icon, label: label, onTap: onTap),
            ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      semanticLabel: label,
      scale: 0.92,
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(color: context.colors.surfaceHigh, shape: BoxShape.circle),
            child: Icon(icon, color: context.scheme.primary),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: context.text.labelMedium?.copyWith(color: context.scheme.onSurface),
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
      child: Card(
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}
