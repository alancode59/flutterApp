import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/services/haptics.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/feedback.dart';
import '../../../core/widgets/skeleton.dart';
import '../../categories/domain/category.dart';
import '../../categories/presentation/category_editor_sheet.dart';
import '../../categories/presentation/category_providers.dart';
import '../../categories/presentation/widgets/category_avatar.dart';
import '../data/movement_repository.dart';
import '../domain/amount_input.dart';
import '../domain/movement.dart';
import 'widgets/amount_keypad.dart';

/// Alta rápida (o edición) de un movimiento: monto → categoría → Guardar.
/// La categoría más usada y el último método de pago vienen preseleccionados,
/// así que un gasto típico se registra en 2–3 toques.
Future<void> showQuickAddSheet(
  BuildContext context, {
  MovementKind kind = MovementKind.expense,
  Movement? editing,
}) {
  final messenger = ScaffoldMessenger.of(context);
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    // Encima de la barra inferior, no dentro de la pestaña.
    useRootNavigator: true,
    builder: (_) => QuickAddSheet(initialKind: editing?.kind ?? kind, editing: editing, messenger: messenger),
  );
}

class QuickAddSheet extends ConsumerStatefulWidget {
  const QuickAddSheet({required this.initialKind, required this.messenger, this.editing, super.key});

  final MovementKind initialKind;
  final Movement? editing;
  final ScaffoldMessengerState messenger;

  @override
  ConsumerState<QuickAddSheet> createState() => _QuickAddSheetState();
}

class _QuickAddSheetState extends ConsumerState<QuickAddSheet> with SingleTickerProviderStateMixin {
  late MovementKind _kind;
  late AmountInput _amount;
  int? _categoryId;
  late DateTime _day;
  PaymentMethod _method = PaymentMethod.cash;
  bool _unexpected = false;
  String? _note;
  String? _source;
  bool _saving = false;
  bool _saved = false;

  late final AnimationController _shake = AnimationController(vsync: this, duration: AppDurations.slow);

  bool get _isEditing => widget.editing != null;
  bool get _isExpense => _kind == MovementKind.expense;

  @override
  void initState() {
    super.initState();
    final e = widget.editing;
    _kind = widget.initialKind;
    if (e != null) {
      _amount = AmountInput.fromCents(e.amountCents);
      _categoryId = e.categoryId;
      _day = DateUtils.dateOnly(e.date);
      _method = e.paymentMethod ?? PaymentMethod.cash;
      _unexpected = e.isUnexpected;
      _note = e.note;
      _source = e.incomeSource;
    } else {
      _amount = const AmountInput();
      _day = DateUtils.dateOnly(DateTime.now());
      unawaited(_loadLastMethod());
    }
  }

  Future<void> _loadLastMethod() async {
    final last = await ref.read(movementRepositoryProvider).lastPaymentMethod();
    if (mounted && last != null && last != PaymentMethod.credit) setState(() => _method = last);
  }

  @override
  void dispose() {
    _shake.dispose();
    super.dispose();
  }

  // ---------- Entrada ----------

  void _press(String key) {
    final next = key == AmountKeypad.backspace ? _amount.backspace() : _amount.append(key);
    if (identical(next, _amount)) {
      _reject();
      return;
    }
    setState(() => _amount = next);
  }

  void _reject() {
    Haptics.warning();
    _shake.forward(from: 0);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) return KeyEventResult.ignored;
    final key = event.logicalKey;
    final char = event.character;
    if (char != null && RegExp(r'^[0-9]$').hasMatch(char)) {
      _press(char);
    } else if (char == '.' || char == ',' || key == LogicalKeyboardKey.numpadDecimal) {
      _press('.');
    } else if (key == LogicalKeyboardKey.backspace) {
      _press(AmountKeypad.backspace);
    } else if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.numpadEnter) {
      unawaited(_save());
    } else {
      return KeyEventResult.ignored;
    }
    return KeyEventResult.handled;
  }

  void _setKind(MovementKind kind) {
    if (kind == _kind) return;
    Haptics.tap();
    setState(() {
      _kind = kind;
      _categoryId = null;
    });
  }

  // ---------- Detalles ----------

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _day,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 1, 12, 31),
      helpText: 'Fecha del movimiento',
    );
    if (picked != null) setState(() => _day = picked);
  }

  Future<void> _editNote() async {
    final result = await _askText(
      title: 'Nota',
      hint: 'Ej. comida con amigos',
      initial: _note,
      maxLength: 80,
    );
    if (result != null) setState(() => _note = result.isEmpty ? null : result);
  }

  Future<void> _editSource() async {
    final suggestions = await ref.read(movementRepositoryProvider).incomeSources();
    if (!mounted) return;
    final result = await _askText(
      title: 'Fuente del ingreso',
      hint: 'Ej. Empresa, cliente, venta',
      initial: _source,
      maxLength: 60,
      suggestions: suggestions,
    );
    if (result != null) setState(() => _source = result.isEmpty ? null : result);
  }

  Future<String?> _askText({
    required String title,
    required String hint,
    String? initial,
    int maxLength = 80,
    List<String> suggestions = const [],
  }) {
    final controller = TextEditingController(text: initial ?? '');
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              maxLength: maxLength,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(hintText: hint, counterText: ''),
              onSubmitted: (v) => Navigator.pop(context, v.trim()),
            ),
            if (suggestions.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final s in suggestions)
                    ActionChip(label: Text(s), onPressed: () => Navigator.pop(context, s)),
                ],
              ),
            ],
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(96, 44)),
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Listo'),
          ),
        ],
      ),
    ).whenComplete(controller.dispose);
  }

  // ---------- Guardar / borrar ----------

  DateTime _composeDate() {
    final original = widget.editing?.date;
    if (original != null && DateUtils.isSameDay(original, _day)) return original;
    final now = DateTime.now();
    if (DateUtils.isSameDay(now, _day)) return now;
    return DateTime(_day.year, _day.month, _day.day, 12);
  }

  Future<void> _save([List<Category> categories = const []]) async {
    if (_saving) return;
    final categoryId = _categoryId ?? categories.firstOrNull?.id ?? _visibleCategories.firstOrNull?.id;
    if (_amount.cents <= 0 || categoryId == null) {
      _reject();
      return;
    }
    final movement = Movement(
      id: widget.editing?.id ?? 0,
      kind: _kind,
      amountCents: _amount.cents,
      categoryId: categoryId,
      date: _composeDate(),
      note: _note,
      paymentMethod: _isExpense ? _method : null,
      cardId: widget.editing?.cardId,
      isUnexpected: _isExpense && _unexpected,
      incomeSource: _isExpense ? null : _source,
      recurringRuleId: widget.editing?.recurringRuleId,
    );

    setState(() => _saving = true);
    final repo = ref.read(movementRepositoryProvider);
    try {
      final id = _isEditing ? movement.id : await repo.add(movement);
      if (_isEditing) await repo.update(movement);
      unawaited(Haptics.success());
      setState(() => _saved = true);
      await Future<void>.delayed(const Duration(milliseconds: 320));
      if (!mounted) return;
      Navigator.pop(context);
      showAppSnackBar(
        widget.messenger,
        _isEditing
            ? 'Cambios guardados'
            : '${_kind.label} de ${Formatters.money(movement.amountCents)} guardado',
        onUndo: _isEditing ? () => repo.update(widget.editing!) : () => repo.delete(id),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      showAppSnackBar(widget.messenger, 'No se pudo guardar. Intenta de nuevo.');
    }
  }

  Future<void> _delete() async {
    final ok = await showConfirmDialog(
      context,
      title: '¿Eliminar este movimiento?',
      message: 'Podrás deshacerlo durante unos segundos.',
    );
    if (!ok || !mounted) return;
    final repo = ref.read(movementRepositoryProvider);
    final deleted = await repo.delete(widget.editing!.id);
    if (!mounted) return;
    Navigator.pop(context);
    if (deleted != null) {
      showAppSnackBar(widget.messenger, 'Movimiento eliminado', onUndo: () => repo.restore(deleted));
    }
  }

  // ---------- UI ----------

  List<Category> _visibleCategories = const [];

  /// Orden de las categorías al abrir la hoja. Se conserva mientras está
  /// abierta para que no se reacomoden (por uso) justo al guardar.
  List<int>? _frozenOrder;
  MovementKind? _frozenKind;

  List<Category> _stableOrder(List<Category> categories) {
    if (categories.isEmpty) return categories;
    if (_frozenOrder == null || _frozenKind != _kind) {
      _frozenOrder = [for (final c in categories) c.id];
      _frozenKind = _kind;
      return categories;
    }
    final order = _frozenOrder!;
    int rank(Category c) {
      final i = order.indexOf(c.id);
      return i < 0 ? order.length : i;
    }

    return [...categories]..sort((a, b) => rank(a).compareTo(rank(b)));
  }

  Future<void> _createCategory() async {
    final id = await showCategoryEditor(context, kind: _kind);
    if (id != null && mounted) setState(() => _categoryId = id);
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesByUsageProvider(_kind));
    final byId = ref.watch(categoriesByIdProvider).value ?? const {};
    var categories = _stableOrder(categoriesAsync.value ?? const <Category>[]);
    // Al editar, la categoría original se muestra aunque esté archivada.
    final original = byId[widget.editing?.categoryId];
    if (original != null && original.kind == _kind && categories.every((c) => c.id != original.id)) {
      categories = [original, ...categories];
    }
    _visibleCategories = categories;
    final selectedId = _categoryId ?? categories.firstOrNull?.id;

    final screenHeight = MediaQuery.sizeOf(context).height;
    final sheetHeight = math.min(screenHeight * 0.92, 800.0);

    return Focus(
      autofocus: true,
      onKeyEvent: _onKey,
      child: SizedBox(
        height: sheetHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final keyHeight = ((constraints.maxHeight - 430) / 4).clamp(44.0, 62.0);
            return Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.xs, AppSpacing.md, AppSpacing.md),
              child: Column(
                children: [
                  _Header(
                    kind: _kind,
                    canChangeKind: !_isEditing,
                    onKind: _setKind,
                    onDelete: _isEditing ? _delete : null,
                  ),
                  Expanded(
                    child: _AmountDisplay(amount: _amount, shake: _shake, kind: _kind),
                  ),
                  SizedBox(
                    height: 92,
                    child: categoriesAsync.isLoading && categories.isEmpty
                        ? const _CategoriesSkeleton()
                        : _CategoryStrip(
                            categories: categories,
                            selectedId: selectedId,
                            onSelect: (id) {
                              Haptics.tap();
                              setState(() => _categoryId = id);
                            },
                            onCreate: _createCategory,
                          ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(height: 40, child: _details(context)),
                  const SizedBox(height: AppSpacing.xs),
                  AmountKeypad(
                    keyHeight: keyHeight,
                    onKey: _press,
                    onClear: () => setState(() => _amount = const AmountInput()),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  _SaveButton(
                    label: _isEditing ? 'Guardar cambios' : 'Guardar ${_kind.label.toLowerCase()}',
                    enabled: _amount.cents > 0 && selectedId != null && !_saving,
                    saving: _saving && !_saved,
                    saved: _saved,
                    onPressed: () => _save(categories),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _details(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());
    final dateLabel = _day == today
        ? 'Hoy'
        : _day == today.subtract(const Duration(days: 1))
        ? 'Ayer'
        : Formatters.dayMonth(_day);

    final chips = <Widget>[
      _DetailChip(icon: Icons.calendar_today_rounded, label: dateLabel, onTap: _pickDate),
      if (_isExpense) ...[
        for (final m in [PaymentMethod.cash, PaymentMethod.debit])
          _DetailChip(
            icon: m == PaymentMethod.cash ? Icons.payments_outlined : Icons.credit_card_rounded,
            label: m.label,
            selected: _method == m,
            onTap: () {
              Haptics.tap();
              setState(() => _method = m);
            },
          ),
        _DetailChip(
          icon: Icons.bolt_rounded,
          label: 'Imprevisto',
          selected: _unexpected,
          selectedColor: context.colors.warning,
          onTap: () {
            Haptics.tap();
            setState(() => _unexpected = !_unexpected);
          },
        ),
      ] else
        _DetailChip(
          icon: Icons.business_center_outlined,
          label: _source ?? 'Fuente',
          selected: _source != null,
          onTap: _editSource,
        ),
      _DetailChip(
        icon: Icons.notes_rounded,
        label: _note ?? 'Nota',
        selected: _note != null,
        onTap: _editNote,
      ),
    ];

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: chips.length,
      separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
      itemBuilder: (_, i) => chips[i],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.kind, required this.canChangeKind, required this.onKind, this.onDelete});

  final MovementKind kind;
  final bool canChangeKind;
  final ValueChanged<MovementKind> onKind;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: 'Cerrar',
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.close_rounded),
        ),
        Expanded(
          child: Center(
            child: canChangeKind
                ? _KindToggle(kind: kind, onChanged: onKind)
                : Text('Editar ${kind.label.toLowerCase()}', style: context.text.titleMedium),
          ),
        ),
        if (onDelete != null)
          IconButton(
            tooltip: 'Eliminar',
            onPressed: onDelete,
            icon: Icon(Icons.delete_outline_rounded, color: context.colors.expense),
          )
        else
          const SizedBox(width: kMinTapTarget),
      ],
    );
  }
}

class _KindToggle extends StatelessWidget {
  const _KindToggle({required this.kind, required this.onChanged});

  final MovementKind kind;
  final ValueChanged<MovementKind> onChanged;

  @override
  Widget build(BuildContext context) {
    const width = 116.0;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: AppDurations.medium,
            curve: AppCurves.emphasized,
            left: kind == MovementKind.expense ? 0 : width,
            top: 0,
            bottom: 0,
            width: width,
            child: Container(
              decoration: BoxDecoration(
                color: context.scheme.primary,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final k in MovementKind.values)
                Semantics(
                  selected: k == kind,
                  button: true,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onChanged(k),
                    child: SizedBox(
                      width: width,
                      height: 40,
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: AppDurations.medium,
                          style: context.text.labelLarge!.copyWith(
                            color: k == kind ? context.scheme.onPrimary : context.scheme.onSurface,
                          ),
                          child: Text(k.label),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AmountDisplay extends StatelessWidget {
  const _AmountDisplay({required this.amount, required this.shake, required this.kind});

  final AmountInput amount;
  final AnimationController shake;
  final MovementKind kind;

  @override
  Widget build(BuildContext context) {
    final color = amount.isEmpty ? context.colors.textSecondary : context.scheme.onSurface;
    return Semantics(
      liveRegion: true,
      label: 'Monto ${Formatters.money(amount.cents)}',
      excludeSemantics: true,
      child: AnimatedBuilder(
        animation: shake,
        builder: (context, child) {
          final t = shake.value;
          final dx = math.sin(t * math.pi * 6) * 10 * (1 - t);
          return Transform.translate(offset: Offset(dx, 0), child: child);
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: AnimatedSwitcher(
                duration: AppDurations.fast,
                transitionBuilder: (child, a) => FadeTransition(
                  opacity: a,
                  child: ScaleTransition(scale: Tween(begin: 0.96, end: 1.0).animate(a), child: child),
                ),
                child: Text(
                  amount.display,
                  key: ValueKey(amount.raw),
                  style: AppTypography.amount(64, color: color),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryStrip extends StatelessWidget {
  const _CategoryStrip({
    required this.categories,
    required this.selectedId,
    required this.onSelect,
    required this.onCreate,
  });

  final List<Category> categories;
  final int? selectedId;
  final ValueChanged<int> onSelect;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length + 1,
      itemBuilder: (context, i) {
        if (i == categories.length) {
          return _Bubble(
            label: 'Nueva',
            selected: false,
            onTap: onCreate,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: context.scheme.outline, width: 1.5),
              ),
              child: Icon(Icons.add_rounded, color: context.colors.textSecondary),
            ),
          );
        }
        final c = categories[i];
        return _Bubble(
              key: ValueKey(c.id),
              label: c.name,
              selected: c.id == selectedId,
              onTap: () => onSelect(c.id),
              child: CategoryAvatar(category: c, size: 52),
            )
            .animate()
            .fadeIn(delay: (25 * i).clamp(0, 300).ms, duration: AppDurations.medium)
            .slideX(begin: 0.2);
      },
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.child,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: 76,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: [
              AnimatedScale(
                scale: selected ? 1.06 : 1,
                duration: AppDurations.medium,
                curve: AppCurves.spring,
                child: AnimatedContainer(
                  duration: AppDurations.medium,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected ? context.scheme.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: child,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: context.text.labelMedium?.copyWith(
                  fontSize: 12,
                  color: selected ? context.scheme.onSurface : context.colors.textSecondary,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoriesSkeleton extends StatelessWidget {
  const _CategoriesSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (var i = 0; i < 6; i++)
          const SizedBox(
            width: 74,
            child: Column(
              children: [
                Skeleton(width: 56, height: 56, radius: 18),
                SizedBox(height: 6),
                Skeleton(width: 44, height: 10),
              ],
            ),
          ),
      ],
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
    this.selectedColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    final accent = selectedColor ?? context.scheme.primary;
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: AnimatedContainer(
          duration: AppDurations.fast,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          decoration: BoxDecoration(
            color: selected ? accent.withValues(alpha: 0.16) : context.colors.surfaceHigh,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: selected ? accent : Colors.transparent),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: selected ? accent : context.colors.textSecondary),
              const SizedBox(width: 6),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 140),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.labelLarge?.copyWith(
                    fontSize: 13,
                    color: selected ? context.scheme.onSurface : context.colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.label,
    required this.enabled,
    required this.saving,
    required this.saved,
    required this.onPressed,
  });

  final String label;
  final bool enabled;
  final bool saving;
  final bool saved;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        child: AnimatedSwitcher(
          duration: AppDurations.medium,
          transitionBuilder: (child, a) => ScaleTransition(scale: a, child: child),
          child: saved
              ? const Icon(Icons.check_rounded, key: ValueKey('ok'), size: 28)
              : saving
              ? SizedBox.square(
                  key: const ValueKey('saving'),
                  dimension: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.5, color: context.scheme.onPrimary),
                )
              : Text(label, key: const ValueKey('label')),
        ),
      ),
    );
  }
}
