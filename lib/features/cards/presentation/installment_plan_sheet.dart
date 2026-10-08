import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/feedback.dart';
import '../data/card_repository.dart';
import '../domain/installment_plan.dart';
import 'card_providers.dart';

/// Detalle de una compra a MSI: calendario de mensualidades y opción de borrarla.
Future<void> showInstallmentPlanSheet(BuildContext context, int planId) async {
  final messenger = ScaffoldMessenger.of(context);
  final container = ProviderScope.containerOf(context);
  final plan = await container.read(cardRepositoryProvider).getPlan(planId);
  if (plan == null || !context.mounted) return;
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    builder: (_) => _PlanSheet(plan: plan, messenger: messenger),
  );
}

class _PlanSheet extends ConsumerWidget {
  const _PlanSheet({required this.plan, required this.messenger});

  final InstallmentPlan plan;
  final ScaffoldMessengerState messenger;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final ok = await showConfirmDialog(
      context,
      title: '¿Eliminar la compra a MSI?',
      message: 'Se borrarán sus ${plan.months} mensualidades. Podrás deshacerlo durante unos segundos.',
    );
    if (!ok || !context.mounted) return;
    final repo = ref.read(cardRepositoryProvider);
    final deleted = await repo.deletePlan(plan.id);
    if (!context.mounted) return;
    Navigator.pop(context);
    if (deleted != null) {
      showAppSnackBar(messenger, 'Compra a MSI eliminada', onUndo: () => repo.restorePlan(deleted));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(cardsByIdProvider).value?[plan.cardId];
    final today = DateUtils.dateOnly(DateTime.now());
    final billed = plan.billedCount(today);
    final dates = plan.installmentDates;
    final amounts = plan.installmentAmounts;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.94,
      builder: (context, scroll) => ListView(
        controller: scroll,
        padding: const EdgeInsets.fromLTRB(AppSpacing.page, 0, AppSpacing.page, AppSpacing.xl),
        children: [
          Row(
            children: [
              Expanded(child: Text(plan.description, style: context.text.titleLarge)),
              IconButton(
                tooltip: 'Eliminar compra',
                onPressed: () => _delete(context, ref),
                icon: Icon(Icons.delete_outline_rounded, color: context.colors.expense),
              ),
            ],
          ),
          Text(
            '${plan.months} meses sin intereses${card != null ? ' · ${card.shortLabel}' : ''} · '
            'compra del ${Formatters.date(plan.purchaseDate)}',
            style: context.text.bodySmall,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _Figure(label: 'Total', cents: plan.totalCents),
              ),
              Expanded(
                child: _Figure(label: 'Mensualidad', cents: plan.monthlyCents),
              ),
              Expanded(
                child: _Figure(label: 'Por pagar', cents: plan.remainingCents(today)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: Column(
              children: [
                for (var i = 0; i < plan.months; i++)
                  ListTile(
                    dense: true,
                    leading: Icon(
                      i < billed ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                      color: i < billed ? context.colors.income : context.colors.textSecondary,
                    ),
                    title: Text('Mensualidad ${i + 1} de ${plan.months}'),
                    subtitle: Text(Formatters.date(dates[i])),
                    trailing: Text(
                      Formatters.money(amounts[i]),
                      style: AppTypography.amount(
                        14,
                        weight: FontWeight.w600,
                        color: context.scheme.onSurface,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Cada mensualidad cuenta como gasto en su mes; la línea de crédito se ocupa por el total.',
            style: context.text.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.label, required this.cents});

  final String label;
  final int cents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.text.labelMedium),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            Formatters.money(cents),
            style: AppTypography.amount(17, weight: FontWeight.w700, color: context.scheme.onSurface),
          ),
        ),
      ],
    );
  }
}
