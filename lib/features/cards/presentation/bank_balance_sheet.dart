import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../core/services/haptics.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/feedback.dart';
import '../../transactions/domain/amount_input.dart';
import '../data/card_repository.dart';
import '../domain/card_summary.dart';
import '../domain/credit_card.dart';

/// Copia los saldos que muestra la app del banco. A partir de ahí la app
/// sigue sola con las compras y pagos que se registren.
Future<void> showBankBalanceSheet(BuildContext context, CardSummary summary) {
  final messenger = ScaffoldMessenger.of(context);
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    builder: (_) => _BankBalanceSheet(summary: summary, messenger: messenger),
  );
}

String _money(int cents) => cents <= 0 ? '' : (cents / 100).toStringAsFixed(cents % 100 == 0 ? 0 : 2);

class _BankBalanceSheet extends ConsumerStatefulWidget {
  const _BankBalanceSheet({required this.summary, required this.messenger});

  final CardSummary summary;
  final ScaffoldMessengerState messenger;

  @override
  ConsumerState<_BankBalanceSheet> createState() => _BankBalanceSheetState();
}

class _BankBalanceSheetState extends ConsumerState<_BankBalanceSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _debt;
  late final TextEditingController _noInterest;
  late final TextEditingController _minimum;
  bool _saving = false;

  CreditCard get _card => widget.summary.card;

  @override
  void initState() {
    super.initState();
    final s = widget.summary;
    // Se precargan los montos que la app calcula hoy, para solo corregir.
    _debt = TextEditingController(text: _money(s.usedCents));
    _noInterest = TextEditingController(text: _money(s.noInterestRemainingCents));
    _minimum = TextEditingController(text: s.minimumFromBank ? _money(s.minimumRemainingCents) : '');
    for (final c in [_debt, _noInterest, _minimum]) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final c in [_debt, _noInterest, _minimum]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      unawaited(Haptics.warning());
      return;
    }
    setState(() => _saving = true);
    final repo = ref.read(cardRepositoryProvider);
    final before = _card;
    final updated = applyBankBalances(
      _card,
      debtCents: parseAmountToCents(_debt.text) ?? 0,
      noInterestCents: parseAmountToCents(_noInterest.text) ?? 0,
      minimumCents: _minimum.text.trim().isEmpty ? null : parseAmountToCents(_minimum.text),
      at: DateTime.now(),
    );
    try {
      await repo.update(updated);
      unawaited(Haptics.success());
      if (!mounted) return;
      Navigator.pop(context);
      showAppSnackBar(
        widget.messenger,
        'Saldos de ${_card.name} actualizados',
        onUndo: () => repo.update(before),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      showAppSnackBar(widget.messenger, 'No se pudieron guardar los saldos');
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.summary;
    final debt = parseAmountToCents(_debt.text) ?? 0;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(AppSpacing.page, 0, AppSpacing.page, AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: BankBalanceFields(
            debt: _debt,
            noInterest: _noInterest,
            minimum: _minimum,
            limitCents: _card.limitCents,
            header: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Actualizar con mi banco', style: context.text.titleLarge),
                const SizedBox(height: 4),
                Text(
                  'Copia los montos de la app de tu banco o de tu estado de cuenta. '
                  'Corte del ${Formatters.dayMonth(s.lastCycle.cutoff)}, '
                  'pago a más tardar el ${Formatters.dayMonth(s.dueDate)}.',
                  style: context.text.bodySmall,
                ),
              ],
            ),
            footer: SizedBox(
              height: 56,
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? SizedBox.square(
                        dimension: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: context.scheme.onPrimary),
                      )
                    : Text(
                        debt > 0
                            ? 'Guardar · disponible ${Formatters.money(_card.limitCents - debt)}'
                            : 'Guardar',
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Registra los saldos del banco en la tarjeta: lo anterior a [at] queda
/// incluido en ellos.
CreditCard applyBankBalances(
  CreditCard card, {
  required int debtCents,
  required int noInterestCents,
  required int? minimumCents,
  required DateTime at,
}) => card.copyWith(
  openingBalanceCents: debtCents,
  statementRemainingCents: noInterestCents,
  minimumPaymentCents: minimumCents,
  balanceDate: at,
);

/// Campos de saldos del banco, compartidos con el alta de tarjeta.
class BankBalanceFields extends StatelessWidget {
  const BankBalanceFields({
    required this.debt,
    required this.noInterest,
    required this.minimum,
    required this.limitCents,
    this.header,
    this.footer,
    super.key,
  });

  final TextEditingController debt;
  final TextEditingController noInterest;
  final TextEditingController minimum;

  /// Para validar que la deuda no pase del límite (0 si aún no se conoce).
  final int limitCents;
  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final debtCents = parseAmountToCents(debt.text) ?? 0;
    final noInterestCents = parseAmountToCents(noInterest.text) ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ?header,
        if (header != null) const SizedBox(height: AppSpacing.lg),
        BankMoneyField(
          controller: debt,
          label: 'Saldo actual (lo que debes en total)',
          helper: limitCents > 0 && debtCents > 0
              ? 'Crédito disponible: ${Formatters.money(limitCents - debtCents)}'
              : 'En tu banco aparece como "Saldo actual" o "Saldo deudor".',
          validator: (v) {
            final cents = parseAmountToCents(v ?? '') ?? 0;
            if (limitCents > 0 && cents > limitCents * 1.2) return 'Es mucho mayor que tu límite';
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        BankMoneyField(
          controller: noInterest,
          label: 'Pago para no generar intereses',
          helper: 'Lo que te falta pagar de tu último corte.',
          validator: (v) {
            final cents = parseAmountToCents(v ?? '') ?? 0;
            if (cents > debtCents) return 'No puede ser mayor que el saldo actual';
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        BankMoneyField(
          controller: minimum,
          label: 'Pago mínimo',
          helper: 'Opcional. Si lo dejas vacío, lo estimamos.',
          validator: (v) {
            final cents = parseAmountToCents(v ?? '') ?? 0;
            if (cents > noInterestCents && noInterestCents > 0) {
              return 'No puede ser mayor que el pago para no generar intereses';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline_rounded, size: 16, color: context.colors.textSecondary),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Desde ahora, cada compra o pago que registres ajusta estos montos. '
                'Puedes volver a copiarlos de tu banco cuando quieras.',
                style: context.text.bodySmall,
              ),
            ),
          ],
        ),
        if (footer != null) ...[const SizedBox(height: AppSpacing.lg), footer!],
      ],
    );
  }
}

class BankMoneyField extends StatelessWidget {
  const BankMoneyField({
    required this.controller,
    required this.label,
    this.helper,
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? helper;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
      decoration: InputDecoration(labelText: label, prefixText: r'$ ', helperText: helper, helperMaxLines: 2),
      validator: (v) {
        if (v != null && v.isNotEmpty && parseAmountToCents(v) == null) return 'Monto no válido';
        return validator?.call(v);
      },
    );
  }
}
