import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../core/widgets/sliding_segmented.dart';
import '../../../core/services/haptics.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/feedback.dart';
import '../../../core/widgets/filter_pill.dart';
import '../../cards/domain/credit_card.dart';
import '../../cards/presentation/card_providers.dart';
import '../../categories/presentation/category_providers.dart';
import '../../categories/presentation/widgets/category_avatar.dart';
import '../../transactions/domain/amount_input.dart';
import '../../transactions/domain/movement.dart';
import '../data/recurring_repository.dart';
import '../domain/recurring_rule.dart';

/// Crea o edita una regla recurrente. Con [preset] se precargan valores
/// (por ejemplo, para "Configurar mi quincena").
Future<void> showRecurringEditor(BuildContext context, {RecurringRule? editing, RecurringRule? preset}) {
  final messenger = ScaffoldMessenger.of(context);
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    builder: (_) => _RecurringEditor(editing: editing, preset: preset, messenger: messenger),
  );
}

class _RecurringEditor extends ConsumerStatefulWidget {
  const _RecurringEditor({required this.editing, required this.preset, required this.messenger});

  final RecurringRule? editing;
  final RecurringRule? preset;
  final ScaffoldMessengerState messenger;

  @override
  ConsumerState<_RecurringEditor> createState() => _RecurringEditorState();
}

class _RecurringEditorState extends ConsumerState<_RecurringEditor> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _amount;
  late final TextEditingController _source;
  late MovementKind _kind;
  int? _categoryId;
  late Frequency _frequency;
  late DateTime _start;
  DateTime? _end;
  PaymentMethod _method = PaymentMethod.debit;
  int? _cardId;
  bool _saving = false;

  bool get _isEditing => widget.editing != null;
  bool get _isExpense => _kind == MovementKind.expense;

  @override
  void initState() {
    super.initState();
    final r = widget.editing ?? widget.preset;
    _name = TextEditingController(text: r?.name ?? '');
    _amount = TextEditingController(
      text: r == null || r.amountCents == 0 ? '' : AmountInput.fromCents(r.amountCents).raw,
    );
    _source = TextEditingController(text: r?.incomeSource ?? '');
    _kind = r?.kind ?? MovementKind.expense;
    _categoryId = (r?.categoryId ?? 0) == 0 ? null : r!.categoryId;
    _frequency = r?.frequency ?? Frequency.monthly;
    _start = DateUtils.dateOnly(r?.startDate ?? DateTime.now());
    _end = r?.endDate;
    _method = r?.paymentMethod ?? PaymentMethod.debit;
    _cardId = _method == PaymentMethod.credit ? r?.cardId : null;
    if (_method == PaymentMethod.credit && _cardId == null) _method = PaymentMethod.debit;
  }

  @override
  void dispose() {
    _name.dispose();
    _amount.dispose();
    _source.dispose();
    super.dispose();
  }

  Future<DateTime?> _pickDate(DateTime initial, {DateTime? first}) => showDatePicker(
    context: context,
    initialDate: initial,
    firstDate: first ?? DateTime(2000),
    lastDate: DateTime(DateTime.now().year + 10),
  );

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final repo = ref.read(recurringRepositoryProvider);
    final base =
        widget.editing ??
        RecurringRule(
          kind: MovementKind.expense,
          name: '',
          amountCents: 0,
          categoryId: 0,
          frequency: Frequency.monthly,
          startDate: _start,
        );
    final rule = base.copyWith(
      kind: _kind,
      name: _name.text.trim(),
      amountCents: parseAmountToCents(_amount.text)!,
      categoryId: _categoryId!,
      frequency: _frequency,
      startDate: _start,
      endDate: _end,
      paymentMethod: _isExpense ? _method : null,
      cardId: _isExpense && _method == PaymentMethod.credit ? _cardId : null,
      incomeSource: _isExpense ? null : _source.text.trim(),
    );
    try {
      if (_isEditing) {
        await repo.update(rule);
      } else {
        await repo.add(rule);
      }
      final created = await repo.generateDue(DateTime.now());
      unawaited(Haptics.success());
      if (!mounted) return;
      Navigator.pop(context);
      final suffix = created == 0
          ? ''
          : created == 1
          ? ' · se registró 1 movimiento'
          : ' · se registraron $created movimientos';
      showAppSnackBar(widget.messenger, '${_isEditing ? 'Cambios guardados' : 'Recurrente creado'}$suffix');
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      showAppSnackBar(widget.messenger, 'No se pudo guardar. Intenta de nuevo.');
    }
  }

  Future<void> _delete() async {
    final ok = await showConfirmDialog(
      context,
      title: '¿Eliminar "${widget.editing!.name}"?',
      message: 'Dejará de registrarse. Los movimientos que ya se generaron se conservan.',
    );
    if (!ok || !mounted) return;
    await ref.read(recurringRepositoryProvider).delete(widget.editing!.id);
    if (!mounted) return;
    Navigator.pop(context);
    showAppSnackBar(widget.messenger, 'Recurrente eliminado');
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesByUsageProvider(_kind)).value ?? const [];
    // Si la categoría elegida no es de este tipo, toma la primera disponible.
    if (categories.isNotEmpty && categories.none((c) => c.id == _categoryId)) {
      _categoryId = categories.first.id;
    }
    final today = DateUtils.dateOnly(DateTime.now());
    final backfill = !_isEditing && _start.isBefore(today);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(AppSpacing.page, 0, AppSpacing.page, AppSpacing.xl),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _isEditing ? 'Editar recurrente' : 'Nuevo recurrente',
                      style: context.text.headlineSmall,
                    ),
                  ),
                  if (_isEditing)
                    IconButton(
                      tooltip: 'Eliminar recurrente',
                      onPressed: _delete,
                      icon: Icon(Icons.delete_outline_rounded, color: context.colors.expense),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              if (!_isEditing) ...[
                SlidingSegmented<MovementKind>(
                  segments: const [
                    Segment(MovementKind.expense, 'Gasto'),
                    Segment(MovementKind.income, 'Ingreso'),
                  ],
                  selected: _kind,
                  onChanged: (k) => setState(() {
                    if (k != _kind) _categoryId = null;
                    _kind = k;
                  }),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              TextFormField(
                controller: _name,
                maxLength: 60,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  hintText: _isExpense ? 'Ej. Renta, Netflix, Luz' : 'Ej. Quincena',
                  counterText: '',
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Escribe un nombre' : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _amount,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                decoration: const InputDecoration(labelText: 'Monto', prefixText: r'$ '),
                validator: (v) {
                  final cents = parseAmountToCents(v ?? '');
                  if (cents == null || cents <= 0) return 'Escribe un monto válido';
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              DropdownButtonFormField<int>(
                key: ValueKey('cat-$_kind-${categories.length}'),
                initialValue: _categoryId,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Categoría'),
                items: [
                  for (final c in categories)
                    DropdownMenuItem(
                      value: c.id,
                      child: Row(
                        children: [
                          CategoryAvatar(category: c, size: 28),
                          const SizedBox(width: AppSpacing.sm),
                          Flexible(child: Text(c.name, overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                    ),
                ],
                onChanged: (v) => setState(() => _categoryId = v),
                validator: (v) => v == null ? 'Elige una categoría' : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              DropdownButtonFormField<Frequency>(
                initialValue: _frequency,
                isExpanded: true,
                decoration: InputDecoration(labelText: 'Frecuencia', helperText: _frequency.description),
                items: [for (final f in Frequency.values) DropdownMenuItem(value: f, child: Text(f.label))],
                onChanged: (v) => setState(() => _frequency = v ?? _frequency),
              ),
              const SizedBox(height: AppSpacing.sm),
              _DateField(
                label: 'Empieza',
                value: Formatters.date(_start),
                onTap: () async {
                  final d = await _pickDate(_start);
                  if (d != null) setState(() => _start = d);
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              _DateField(
                label: 'Termina',
                value: _end == null ? 'Sin fecha de fin' : Formatters.date(_end!),
                onTap: () async {
                  final d = await _pickDate(_end ?? _start, first: _start);
                  if (d != null) setState(() => _end = d);
                },
                onClear: _end == null ? null : () => setState(() => _end = null),
              ),
              const SizedBox(height: AppSpacing.md),
              if (_isExpense)
                _PaymentPicker(
                  method: _method,
                  cardId: _cardId,
                  onChanged: (method, cardId) => setState(() {
                    _method = method;
                    _cardId = cardId;
                  }),
                )
              else
                TextFormField(
                  controller: _source,
                  maxLength: 60,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Fuente del ingreso (opcional)',
                    hintText: 'Ej. Empresa',
                    counterText: '',
                  ),
                ),
              if (backfill) ...[
                const SizedBox(height: AppSpacing.md),
                _Info(
                  text:
                      'La fecha de inicio ya pasó: se registrarán automáticamente los movimientos '
                      'desde el ${Formatters.date(_start)} hasta hoy.',
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              FilledButton(
                onPressed: _saving ? null : _save,
                child: Text(_isEditing ? 'Guardar cambios' : 'Crear recurrente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({required this.label, required this.value, required this.onTap, this.onClear});

  final String label;
  final String value;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: onClear == null
              ? const Icon(Icons.calendar_today_rounded, size: 20)
              : IconButton(
                  tooltip: 'Quitar fecha',
                  onPressed: onClear,
                  icon: const Icon(Icons.close_rounded),
                ),
        ),
        child: Text(value, style: context.text.bodyLarge),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: context.scheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 18, color: context.scheme.primary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(text, style: context.text.bodySmall?.copyWith(color: context.scheme.onSurface)),
          ),
        ],
      ),
    );
  }
}

/// Efectivo, débito o una tarjeta de crédito específica.
class _PaymentPicker extends ConsumerWidget {
  const _PaymentPicker({required this.method, required this.cardId, required this.onChanged});

  final PaymentMethod method;
  final int? cardId;
  final void Function(PaymentMethod method, int? cardId) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(activeCardsProvider).value ?? const <CreditCard>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Se paga con', style: context.text.labelMedium),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final m in [PaymentMethod.cash, PaymentMethod.debit])
              SizedBox(
                height: 38,
                child: FilterPill(label: m.label, selected: method == m, onTap: () => onChanged(m, null)),
              ),
            for (final c in cards)
              SizedBox(
                height: 38,
                child: FilterPill(
                  label: c.name,
                  dotColor: c.color,
                  selected: method == PaymentMethod.credit && cardId == c.id,
                  onTap: () => onChanged(PaymentMethod.credit, c.id),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
