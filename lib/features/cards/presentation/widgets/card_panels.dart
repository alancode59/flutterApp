import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_tokens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/animated_amount.dart';
import '../../../../core/widgets/pressable.dart';
import '../../domain/card_summary.dart';
import '../../domain/installment_plan.dart';

/// Color y texto del estado de pago del último corte.
(Color, String, IconData) paymentStatusStyle(BuildContext context, CardSummary s) => switch (s.status) {
  PaymentStatus.overdue => (context.colors.expense, 'Vencido', Icons.error_rounded),
  PaymentStatus.pending when s.daysToNextDue <= 5 => (
    context.colors.warning,
    'Vence pronto',
    Icons.schedule_rounded,
  ),
  PaymentStatus.pending => (context.scheme.primary, 'Pendiente', Icons.schedule_rounded),
  PaymentStatus.paid => (context.colors.income, 'Pagado', Icons.check_circle_rounded),
  PaymentStatus.none => (context.colors.income, 'Al corriente', Icons.check_circle_rounded),
};

/// Color de la utilización: verde hasta 30 %, ámbar hasta 70 %, rojo arriba.
Color utilizationColor(BuildContext context, double u) => u < 0.3
    ? context.colors.income
    : u < 0.7
    ? context.colors.warning
    : context.colors.expense;

class StatusChip extends StatelessWidget {
  const StatusChip({required this.color, required this.label, this.icon, super.key});

  final Color color;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 14, color: color), const SizedBox(width: 4)],
          Text(
            label,
            style: context.text.labelMedium?.copyWith(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// Contenedor de las secciones de una tarjeta.
class Panel extends StatelessWidget {
  const Panel({required this.child, this.padding = const EdgeInsets.all(AppSpacing.lg), super.key});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(padding: padding, child: child),
  );
}

/// Fila "concepto ........ monto".
class AmountRow extends StatelessWidget {
  const AmountRow({required this.label, required this.cents, this.color, this.signed = false, super.key});

  final String label;
  final int cents;
  final Color? color;
  final bool signed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: context.text.bodyMedium?.copyWith(color: context.colors.textSecondary)),
          ),
          Text(
            signed ? Formatters.moneySigned(cents) : Formatters.money(cents),
            style: AppTypography.amount(
              15,
              weight: FontWeight.w600,
              color: color ?? context.scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

/// Pago del último corte: cuánto, para cuándo y cuánto llevas pagado.
class NextPaymentPanel extends StatelessWidget {
  const NextPaymentPanel({required this.summary, this.onPay, this.onSync, super.key});

  final CardSummary summary;
  final VoidCallback? onPay;

  /// Abre "Actualizar con mi banco" para corregir los montos.
  final VoidCallback? onSync;

  @override
  Widget build(BuildContext context) {
    final s = summary;
    final (color, label, icon) = paymentStatusStyle(context, s);
    final owes = s.status == PaymentStatus.pending || s.status == PaymentStatus.overdue;

    return Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('Pago del corte', style: context.text.titleMedium)),
              StatusChip(color: color, label: label, icon: icon),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (owes) ...[
            Text('Para no generar intereses', style: context.text.labelMedium),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: AnimatedAmount(
                cents: s.noInterestRemainingCents,
                smallCents: true,
                style: AppTypography.amount(32, color: context.scheme.onSurface),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              s.status == PaymentStatus.overdue
                  ? 'Venció el ${Formatters.dayMonth(s.dueDate)}'
                  : 'Fecha límite ${Formatters.dayMonth(s.dueDate)} · ${Formatters.relativeDays(s.dueDate, s.today)}',
              style: context.text.bodySmall?.copyWith(color: color),
            ),
            const SizedBox(height: AppSpacing.md),
            _Progress(value: s.statementPaidFraction, color: context.colors.income),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Pagado ${Formatters.money(s.paidSinceStatementCents)} de ${Formatters.money(s.statementCents)}',
                    style: context.text.bodySmall,
                  ),
                ),
              ],
            ),
            if (s.minimumRemainingCents > 0) ...[
              const Divider(height: AppSpacing.xl),
              AmountRow(
                label: s.minimumFromBank ? 'Pago mínimo' : 'Pago mínimo (aprox.)',
                cents: s.minimumRemainingCents,
              ),
            ],
          ] else ...[
            Text(
              s.status == PaymentStatus.paid
                  ? 'Cubriste el corte del ${Formatters.dayMonth(s.lastCycle.cutoff)}. ¡Sin intereses!'
                  : 'El último corte no dejó saldo por pagar.',
              style: context.text.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Tu siguiente fecha límite es el ${Formatters.dayMonth(s.currentCycle.dueDate)}.',
              style: context.text.bodySmall,
            ),
          ],
          if (onPay != null) ...[
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: owes
                  ? FilledButton.icon(
                      onPressed: onPay,
                      icon: const Icon(Icons.payments_rounded),
                      label: const Text('Registrar pago'),
                    )
                  : OutlinedButton.icon(
                      onPressed: onPay,
                      icon: const Icon(Icons.payments_outlined),
                      label: const Text('Registrar un pago'),
                    ),
            ),
          ],
          if (onSync != null) ...[
            const SizedBox(height: AppSpacing.xs),
            SyncFooter(summary: s, onSync: onSync!),
          ],
        ],
      ),
    );
  }
}

/// Lo que lleva el periodo abierto: el corte "de cuánto me va a llegar".
class ProjectedPanel extends StatelessWidget {
  const ProjectedPanel({required this.summary, super.key});

  final CardSummary summary;

  @override
  Widget build(BuildContext context) {
    final s = summary;
    final carried = s.carriedCents;

    return Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('Corte proyectado', style: context.text.titleMedium)),
              StatusChip(
                color: context.scheme.primary,
                icon: Icons.content_cut_rounded,
                label: s.daysToCutoff == 0
                    ? 'Corta hoy'
                    : 'Corta ${Formatters.relativeDays(s.currentCycle.cutoff, s.today)}',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: AnimatedAmount(
              cents: s.projectedStatementCents,
              smallCents: true,
              style: AppTypography.amount(32, color: context.scheme.onSurface),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Periodo ${s.currentCycle.label} · pagarías a más tardar el ${Formatters.dayMonth(s.currentCycle.dueDate)}',
            style: context.text.bodySmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          AmountRow(label: 'Compras del periodo', cents: s.cyclePurchasesCents),
          if (s.cycleInstallmentsCents > 0)
            AmountRow(label: 'Mensualidades MSI', cents: s.cycleInstallmentsCents),
          if (carried > 0)
            AmountRow(label: 'Saldo anterior sin pagar', cents: carried, color: context.colors.warning)
          else if (carried < 0)
            AmountRow(label: 'Saldo a favor', cents: -carried, color: context.colors.income),
        ],
      ),
    );
  }
}

/// Uso de la línea de crédito.
class CreditLinePanel extends StatelessWidget {
  const CreditLinePanel({required this.summary, this.onSync, super.key});

  final CardSummary summary;
  final VoidCallback? onSync;

  @override
  Widget build(BuildContext context) {
    final s = summary;
    final color = utilizationColor(context, s.utilization);
    final hint = s.utilization < 0.3
        ? 'Excelente: mantenerla abajo del 30 % cuida tu historial.'
        : s.utilization < 0.7
        ? 'Moderada. Abajo del 30 % es lo ideal.'
        : 'Alta. Intenta bajarla para cuidar tu historial.';

    return Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('Línea de crédito', style: context.text.titleMedium)),
              Text(
                Formatters.percent(s.utilization.clamp(0, 9.99)),
                style: AppTypography.amount(15, weight: FontWeight.w700, color: color),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _Progress(value: s.utilization.clamp(0.0, 1.0), color: color),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _MiniStat(label: 'Disponible', cents: s.availableCents),
              ),
              Expanded(
                child: _MiniStat(label: 'Usado', cents: s.usedCents),
              ),
              Expanded(
                child: _MiniStat(label: 'Límite', cents: s.limitCents),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(hint, style: context.text.bodySmall),
          if (s.msiPendingCents > 0) ...[
            const SizedBox(height: 4),
            Text(
              'Incluye ${Formatters.money(s.msiPendingCents)} de mensualidades MSI por venir.',
              style: context.text.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.cents});

  final String label;
  final int cents;

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
            Formatters.money(cents),
            style: AppTypography.amount(15, weight: FontWeight.w600, color: context.scheme.onSurface),
          ),
        ),
      ],
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value),
        duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : AppDurations.counter,
        curve: AppCurves.emphasized,
        builder: (_, v, _) => LinearProgressIndicator(
          value: v,
          minHeight: 8,
          color: color,
          backgroundColor: context.colors.surfaceHigh,
        ),
      ),
    );
  }
}

/// Renglón de una compra a MSI con su avance.
class InstallmentPlanTile extends StatelessWidget {
  const InstallmentPlanTile({required this.plan, required this.today, this.onTap, super.key});

  final InstallmentPlan plan;
  final DateTime today;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final billed = plan.billedCount(today);
    final done = billed >= plan.months;
    final progress = billed / plan.months;

    return Pressable(
      onTap: onTap,
      scale: 0.98,
      semanticLabel:
          '${plan.description}, $billed de ${plan.months} mensualidades de ${Formatters.money(plan.monthlyCents)}',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 44,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress),
                    duration: AppDurations.counter,
                    curve: AppCurves.emphasized,
                    builder: (_, v, _) => CircularProgressIndicator(
                      value: v,
                      strokeWidth: 4,
                      strokeCap: StrokeCap.round,
                      color: done ? context.colors.income : context.scheme.primary,
                      backgroundColor: context.colors.surfaceHigh,
                    ),
                  ),
                  Text(
                    '$billed/${plan.months}',
                    style: context.text.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.scheme.onSurface,
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.titleSmall?.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    done
                        ? 'Liquidada · ${Formatters.money(plan.totalCents)}'
                        : '${plan.months} MSI · falta ${Formatters.money(plan.remainingCents(today))}',
                    style: context.text.bodySmall,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Formatters.money(plan.monthlyCents),
                  style: AppTypography.amount(15, weight: FontWeight.w600, color: context.scheme.onSurface),
                ),
                Text('al mes', style: context.text.labelSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// "Saldos del banco del 7 oct · Actualizar": recuerda de dónde salen los montos.
class SyncFooter extends StatelessWidget {
  const SyncFooter({required this.summary, required this.onSync, super.key});

  final CardSummary summary;
  final VoidCallback onSync;

  @override
  Widget build(BuildContext context) {
    final date = summary.card.balanceDate;
    final caption = date == null
        ? '¿No coincide con tu banco?'
        : 'Con saldos de tu banco del ${Formatters.dayMonth(date)}';
    return Row(
      children: [
        Icon(Icons.account_balance_rounded, size: 14, color: context.colors.textSecondary),
        const SizedBox(width: 6),
        Expanded(child: Text(caption, style: context.text.bodySmall)),
        TextButton(onPressed: onSync, child: const Text('Actualizar')),
      ],
    );
  }
}
