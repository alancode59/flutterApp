import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../core/services/haptics.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/feedback.dart';
import '../../../core/widgets/sliding_segmented.dart';
import '../../transactions/domain/amount_input.dart';
import '../data/card_repository.dart';
import '../domain/card_style.dart';
import '../domain/credit_card.dart';
import 'bank_balance_sheet.dart';
import 'widgets/credit_card_view.dart';
import 'widgets/day_picker.dart';

/// Agrega o edita una tarjeta. Devuelve el id guardado, o null si se canceló.
Future<int?> showCardEditor(BuildContext context, {CreditCard? editing}) {
  final messenger = ScaffoldMessenger.of(context);
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    builder: (_) => _CardEditor(editing: editing, messenger: messenger),
  );
}

class _CardEditor extends ConsumerStatefulWidget {
  const _CardEditor({required this.editing, required this.messenger});

  final CreditCard? editing;
  final ScaffoldMessengerState messenger;

  @override
  ConsumerState<_CardEditor> createState() => _CardEditorState();
}

class _CardEditorState extends ConsumerState<_CardEditor> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _bank;
  late final TextEditingController _last4;
  late final TextEditingController _limit;
  // Saldos del banco: solo al dar de alta; después se actualizan desde la tarjeta.
  final _debt = TextEditingController();
  final _noInterest = TextEditingController();
  final _minimum = TextEditingController();
  late CardNetwork _network;
  late int _color;
  int? _cutoffDay;
  int? _dueDay;
  bool _saving = false;
  bool _showDayErrors = false;

  bool get _isEditing => widget.editing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.editing;
    String money(int? cents) =>
        cents == null || cents == 0 ? '' : (cents / 100).toStringAsFixed(cents % 100 == 0 ? 0 : 2);
    _name = TextEditingController(text: e?.name ?? '');
    _bank = TextEditingController(text: e?.bank ?? '');
    _last4 = TextEditingController(text: e?.last4 ?? '');
    _limit = TextEditingController(text: money(e?.limitCents));
    _network = e?.network ?? CardNetwork.visa;
    _color = e?.colorIndex ?? 2;
    _cutoffDay = e?.cutoffDay;
    _dueDay = e?.dueDay;
    for (final c in [_name, _bank, _last4, _limit, _debt, _noInterest]) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final c in [_name, _bank, _last4, _limit, _debt, _noInterest, _minimum]) {
      c.dispose();
    }
    super.dispose();
  }

  /// Al editar se parte de la tarjeta guardada para conservar sus saldos del banco.
  CreditCard get _draft {
    final base =
        widget.editing ??
        CreditCard(name: '', limitCents: 0, cutoffDay: 15, dueDay: 5, createdAt: DateTime.now());
    return base.copyWith(
      name: _name.text.trim().isEmpty ? 'Mi tarjeta' : _name.text.trim(),
      bank: _bank.text,
      last4: _last4.text.length == 4 ? _last4.text : null,
      network: _network,
      colorIndex: _color,
      limitCents: parseAmountToCents(_limit.text) ?? 0,
      cutoffDay: _cutoffDay ?? base.cutoffDay,
      dueDay: _dueDay ?? base.dueDay,
    );
  }

  Future<void> _pickDay({required bool cutoff}) async {
    final picked = await showDayPicker(
      context,
      title: cutoff ? 'Día de corte' : 'Día límite de pago',
      subtitle: cutoff
          ? 'Lo encuentras en tu estado de cuenta como "Fecha de corte".'
          : 'Normalmente unos 20 días después del corte.',
      selected: cutoff ? _cutoffDay : _dueDay,
    );
    if (picked == null) return;
    setState(() {
      if (cutoff) {
        _cutoffDay = picked;
        // Sugerencia típica en México: 20 días después del corte.
        _dueDay ??= DateTime(2026, 1, picked + 20).day;
      } else {
        _dueDay = picked;
      }
    });
  }

  Future<void> _save() async {
    setState(() => _showDayErrors = true);
    final formOk = _formKey.currentState!.validate();
    if (!formOk || _cutoffDay == null || _dueDay == null) {
      unawaited(Haptics.warning());
      return;
    }
    final repo = ref.read(cardRepositoryProvider);
    setState(() => _saving = true);
    try {
      var card = _draft.copyWith(name: _name.text.trim());
      if (!_isEditing) {
        card = applyBankBalances(
          card,
          debtCents: parseAmountToCents(_debt.text) ?? 0,
          noInterestCents: parseAmountToCents(_noInterest.text) ?? 0,
          minimumCents: _minimum.text.trim().isEmpty ? null : parseAmountToCents(_minimum.text),
          at: DateTime.now(),
        );
      }
      final id = _isEditing ? card.id : await repo.add(card);
      if (_isEditing) await repo.update(card);
      unawaited(Haptics.success());
      if (!mounted) return;
      Navigator.pop(context, id);
      showAppSnackBar(widget.messenger, _isEditing ? 'Tarjeta actualizada' : 'Tarjeta agregada');
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      showAppSnackBar(widget.messenger, 'No se pudo guardar la tarjeta');
    }
  }

  Future<void> _remove() async {
    final card = widget.editing!;
    final ok = await showConfirmDialog(
      context,
      title: '¿Quitar "${card.name}"?',
      message: 'Si ya tiene compras o pagos, se archivará: dejará de aparecer pero tu historial se conserva.',
      confirmLabel: 'Quitar',
    );
    if (!ok || !mounted) return;
    final repo = ref.read(cardRepositoryProvider);
    final result = await repo.remove(card.id);
    if (!mounted) return;
    Navigator.pop(context);
    showAppSnackBar(
      widget.messenger,
      result == CardRemoval.archived ? 'Tarjeta archivada' : 'Tarjeta eliminada',
      onUndo: result == CardRemoval.archived
          ? () => repo.setArchived(card.id, archived: false)
          : () => repo.add(card),
    );
  }

  @override
  Widget build(BuildContext context) {
    final draft = _draft;
    final schedule = _cutoffDay != null && _dueDay != null ? draft.cycleOf(DateTime.now()) : null;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.94,
        maxChildSize: 0.94,
        minChildSize: 0.5,
        builder: (context, scroll) => Form(
          key: _formKey,
          child: ListView(
            controller: scroll,
            padding: const EdgeInsets.fromLTRB(AppSpacing.page, 0, AppSpacing.page, AppSpacing.xl),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _isEditing ? 'Editar tarjeta' : 'Nueva tarjeta',
                      style: context.text.titleLarge,
                    ),
                  ),
                  if (_isEditing)
                    IconButton(
                      tooltip: 'Quitar tarjeta',
                      onPressed: _remove,
                      icon: Icon(Icons.delete_outline_rounded, color: context.colors.expense),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: AnimatedSwitcher(
                    duration: AppDurations.medium,
                    child: CreditCardView(key: ValueKey(_color), card: draft),
                  ),
                ),
              ).animate().fadeIn(duration: AppDurations.slow).scale(begin: const Offset(0.94, 0.94)),
              const SizedBox(height: AppSpacing.lg),
              _ColorPicker(
                selected: _color,
                onSelect: (i) {
                  Haptics.tap();
                  setState(() => _color = i);
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                controller: _name,
                maxLength: 30,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nombre o alias',
                  hintText: 'Ej. Oro, Viajes',
                  counterText: '',
                ),
                validator: (v) => v == null || v.trim().isEmpty ? 'Ponle un nombre para reconocerla' : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _bank,
                      maxLength: 24,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Banco',
                        hintText: 'Ej. BBVA',
                        counterText: '',
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _last4,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: 'Últimos 4', counterText: ''),
                      validator: (v) => v != null && v.isNotEmpty && v.length != 4 ? '4 dígitos' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              SlidingSegmented<CardNetwork>(
                segments: const [
                  Segment(CardNetwork.visa, 'Visa'),
                  Segment(CardNetwork.mastercard, 'Mastercard'),
                  Segment(CardNetwork.amex, 'Amex'),
                  Segment(CardNetwork.other, 'Otra'),
                ],
                selected: _network,
                onChanged: (n) => setState(() => _network = n),
              ),
              const SizedBox(height: AppSpacing.md),
              BankMoneyField(
                controller: _limit,
                label: 'Límite de crédito',
                validator: (v) =>
                    (parseAmountToCents(v ?? '') ?? 0) <= 0 ? 'Escribe el límite de tu tarjeta' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _DayTile(
                      label: 'Día de corte',
                      day: _cutoffDay,
                      error: _showDayErrors && _cutoffDay == null,
                      onTap: () => _pickDay(cutoff: true),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _DayTile(
                      label: 'Límite de pago',
                      day: _dueDay,
                      error: _showDayErrors && _dueDay == null,
                      onTap: () => _pickDay(cutoff: false),
                    ),
                  ),
                ],
              ),
              AnimatedSize(
                duration: AppDurations.medium,
                curve: AppCurves.standard,
                child: schedule == null
                    ? const SizedBox(width: double.infinity)
                    : Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.sm),
                        child: _Hint(
                          icon: Icons.event_available_rounded,
                          text:
                              'Próximo corte: ${Formatters.dayMonth(schedule.cutoff)} · '
                              'pagas a más tardar el ${Formatters.dayMonth(schedule.dueDate)}.',
                        ),
                      ),
              ),
              if (!_isEditing) ...[
                const SizedBox(height: AppSpacing.xl),
                Text('Saldo según tu banco', style: context.text.titleMedium),
                const SizedBox(height: 2),
                Text(
                  'Cópialo de la app de tu banco. Déjalo vacío si no debes nada.',
                  style: context.text.bodySmall,
                ),
                const SizedBox(height: AppSpacing.md),
                BankBalanceFields(
                  debt: _debt,
                  noInterest: _noInterest,
                  minimum: _minimum,
                  limitCents: parseAmountToCents(_limit.text) ?? 0,
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                height: 56,
                child: FilledButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? SizedBox.square(
                          dimension: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5, color: context.scheme.onPrimary),
                        )
                      : Text(_isEditing ? 'Guardar cambios' : 'Agregar tarjeta'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({required this.selected, required this.onSelect});

  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: CardStyle.all.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
        itemBuilder: (context, i) {
          final style = CardStyle.all[i];
          final isSelected = i == selected;
          return Semantics(
            label: 'Color ${style.name}',
            selected: isSelected,
            button: true,
            child: GestureDetector(
              onTap: () => onSelect(i),
              child: AnimatedContainer(
                duration: AppDurations.medium,
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? context.scheme.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: style.color,
                    shape: BoxShape.circle,
                    border: Border.all(color: context.scheme.outline, width: 0.5),
                  ),
                  child: isSelected ? Icon(Icons.check_rounded, size: 20, color: style.foreground) : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DayTile extends StatelessWidget {
  const _DayTile({required this.label, required this.day, required this.error, required this.onTap});

  final String label;
  final int? day;
  final bool error;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$label${day != null ? ', día $day' : ', sin elegir'}',
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: AnimatedContainer(
          duration: AppDurations.medium,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: context.colors.surfaceHigh,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: error ? context.colors.expense : Colors.transparent, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.text.labelMedium?.copyWith(color: error ? context.colors.expense : null),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      day == null ? 'Elegir' : 'Día $day',
                      style: context.text.titleMedium?.copyWith(
                        color: day == null ? context.colors.textSecondary : null,
                      ),
                    ),
                  ),
                  Icon(Icons.calendar_month_rounded, size: 18, color: context.colors.textSecondary),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: context.scheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: context.scheme.primary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(text, style: context.text.bodySmall?.copyWith(color: context.scheme.onSurface)),
          ),
        ],
      ),
    );
  }
}
