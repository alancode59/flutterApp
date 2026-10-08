import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/services/haptics.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/feedback.dart';
import '../../transactions/domain/amount_input.dart';
import '../data/card_repository.dart';
import '../domain/card_payment.dart';
import '../domain/card_summary.dart';

/// Registra un pago a la tarjeta con montos sugeridos del último corte.
Future<void> showCardPaymentSheet(BuildContext context, CardSummary summary) {
  final messenger = ScaffoldMessenger.of(context);
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    builder: (_) => _PaymentSheet(summary: summary, messenger: messenger),
  );
}

enum _Option { noInterest, minimum, projected, other }

class _PaymentSheet extends ConsumerStatefulWidget {
  const _PaymentSheet({required this.summary, required this.messenger});

  final CardSummary summary;
  final ScaffoldMessengerState messenger;

  @override
  ConsumerState<_PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends ConsumerState<_PaymentSheet> {
  final _other = TextEditingController();
  final _otherFocus = FocusNode();
  late _Option _option;
  DateTime _date = DateUtils.dateOnly(DateTime.now());
  bool _saving = false;

  CardSummary get _s => widget.summary;

  List<(_Option, String, int)> get _options => [
    if (_s.noInterestRemainingCents > 0) ...[
      (_Option.noInterest, 'Para no generar intereses', _s.noInterestRemainingCents),
      if (_s.minimumRemainingCents > 0 && _s.minimumRemainingCents < _s.noInterestRemainingCents)
        (
          _Option.minimum,
          _s.minimumFromBank ? 'Pago mínimo' : 'Pago mínimo (aprox.)',
          _s.minimumRemainingCents,
        ),
    ] else if (_s.projectedStatementCents > 0)
      (_Option.projected, 'Lo que llevas este periodo', _s.projectedStatementCents),
  ];

  @override
  void initState() {
    super.initState();
    _option = _options.firstOrNull?.$1 ?? _Option.other;
  }

  @override
  void dispose() {
    _other.dispose();
    _otherFocus.dispose();
    super.dispose();
  }

  int? get _amount => _option == _Option.other
      ? parseAmountToCents(_other.text)
      : _options.firstWhere((o) => o.$1 == _option).$3;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
      helpText: 'Fecha del pago',
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    final amount = _amount;
    if (amount == null || amount <= 0) {
      unawaited(Haptics.warning());
      _otherFocus.requestFocus();
      return;
    }
    setState(() => _saving = true);
    final repo = ref.read(cardRepositoryProvider);
    final now = DateTime.now();
    final date = DateUtils.isSameDay(_date, now) ? now : DateTime(_date.year, _date.month, _date.day, 12);
    try {
      final id = await repo.addPayment(CardPayment(cardId: _s.card.id, amountCents: amount, date: date));
      unawaited(Haptics.success());
      if (!mounted) return;
      Navigator.pop(context);
      showAppSnackBar(
        widget.messenger,
        'Pago de ${Formatters.money(amount)} registrado',
        onUndo: () => repo.deletePayment(id),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      showAppSnackBar(widget.messenger, 'No se pudo registrar el pago');
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(AppSpacing.page, 0, AppSpacing.page, AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Pagar ${_s.card.name}', style: context.text.titleLarge),
            const SizedBox(height: 4),
            Text(
              _s.noInterestRemainingCents > 0
                  ? 'Corte del ${Formatters.dayMonth(_s.lastCycle.cutoff)} · '
                        'fecha límite ${Formatters.dayMonth(_s.dueDate)}'
                  : 'No tienes saldo pendiente del último corte.',
              style: context.text.bodySmall,
            ),
            const SizedBox(height: AppSpacing.md),
            for (final (option, label, cents) in _options) ...[
              _OptionTile(
                label: label,
                amount: Formatters.money(cents),
                selected: _option == option,
                onTap: () {
                  Haptics.tap();
                  setState(() => _option = option);
                  FocusScope.of(context).unfocus();
                },
              ),
              const SizedBox(height: AppSpacing.xs),
            ],
            _OptionTile(
              label: 'Otro monto',
              selected: _option == _Option.other,
              onTap: () {
                Haptics.tap();
                setState(() => _option = _Option.other);
                _otherFocus.requestFocus();
              },
              child: AnimatedSize(
                duration: AppDurations.medium,
                curve: AppCurves.standard,
                child: _option != _Option.other
                    ? const SizedBox(width: double.infinity)
                    : Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.sm),
                        child: TextField(
                          controller: _other,
                          focusNode: _otherFocus,
                          autofocus: _options.isEmpty,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                          style: AppTypography.amount(22, color: context.scheme.onSurface),
                          decoration: const InputDecoration(prefixText: r'$ ', hintText: '0.00'),
                          onChanged: (_) => setState(() {}),
                          onSubmitted: (_) => _save(),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today_rounded),
              title: const Text('Fecha del pago'),
              trailing: Text(
                _date == today ? 'Hoy' : Formatters.date(_date),
                style: context.text.labelLarge?.copyWith(color: context.scheme.primary),
              ),
              onTap: _pickDate,
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded, size: 16, color: context.colors.textSecondary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'El pago no cuenta como gasto: tus compras ya se contaron el día que las hiciste.',
                    style: context.text.bodySmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              height: 56,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? SizedBox.square(
                        dimension: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: context.scheme.onPrimary),
                      )
                    : Text(
                        (_amount ?? 0) > 0
                            ? 'Registrar pago de ${Formatters.money(_amount!)}'
                            : 'Registrar pago',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
    this.amount,
    this.child,
  });

  final String label;
  final String? amount;
  final bool selected;
  final VoidCallback onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppDurations.medium,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: selected ? context.scheme.primaryContainer : context.colors.surfaceHigh,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: selected ? context.scheme.primary : Colors.transparent, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  AnimatedSwitcher(
                    duration: AppDurations.fast,
                    child: Icon(
                      selected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                      key: ValueKey(selected),
                      size: 22,
                      color: selected ? context.scheme.primary : context.colors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Text(label, style: context.text.titleSmall)),
                  if (amount != null)
                    Text(
                      amount!,
                      style: AppTypography.amount(
                        16,
                        weight: FontWeight.w600,
                        color: context.scheme.onSurface,
                      ),
                    ),
                ],
              ),
              ?child,
            ],
          ),
        ),
      ),
    );
  }
}
