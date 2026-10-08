import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../core/widgets/sliding_segmented.dart';
import '../../../core/services/haptics.dart';
import '../../../core/widgets/feedback.dart';
import '../../transactions/domain/movement.dart';
import '../data/category_repository.dart';
import '../domain/category.dart';
import '../domain/category_catalog.dart';
import 'widgets/category_avatar.dart';

/// Crea o edita una categoría. Devuelve el id guardado, o null si se canceló.
Future<int?> showCategoryEditor(
  BuildContext context, {
  MovementKind kind = MovementKind.expense,
  Category? editing,
}) {
  final messenger = ScaffoldMessenger.of(context);
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    builder: (_) => _CategoryEditor(initialKind: kind, editing: editing, messenger: messenger),
  );
}

class _CategoryEditor extends ConsumerStatefulWidget {
  const _CategoryEditor({required this.initialKind, required this.editing, required this.messenger});

  final MovementKind initialKind;
  final Category? editing;
  final ScaffoldMessengerState messenger;

  @override
  ConsumerState<_CategoryEditor> createState() => _CategoryEditorState();
}

class _CategoryEditorState extends ConsumerState<_CategoryEditor> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late MovementKind _kind;
  late String _icon;
  late int _color;
  String? _nameError;
  bool _saving = false;

  bool get _isEditing => widget.editing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.editing;
    _name = TextEditingController(text: e?.name ?? '');
    _kind = e?.kind ?? widget.initialKind;
    _icon = e?.iconKey ?? 'more_horiz';
    _color = e?.colorValue ?? CategoryCatalog.colors[8];
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Category get _draft => Category(
    id: widget.editing?.id ?? 0,
    name: _name.text.trim(),
    iconKey: _icon,
    colorValue: _color,
    kind: _kind,
    archived: widget.editing?.archived ?? false,
  );

  Future<void> _save() async {
    setState(() => _nameError = null);
    if (!_formKey.currentState!.validate()) return;
    final repo = ref.read(categoryRepositoryProvider);
    setState(() => _saving = true);
    try {
      if (await repo.nameExists(_name.text, _kind, exceptId: widget.editing?.id)) {
        setState(() {
          _saving = false;
          _nameError = 'Ya tienes una categoría con ese nombre';
        });
        return;
      }
      final id = _isEditing ? widget.editing!.id : await repo.add(_draft);
      if (_isEditing) await repo.update(_draft);
      unawaited(Haptics.success());
      if (!mounted) return;
      Navigator.pop(context, id);
      showAppSnackBar(widget.messenger, _isEditing ? 'Categoría actualizada' : 'Categoría creada');
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      showAppSnackBar(widget.messenger, 'No se pudo guardar la categoría');
    }
  }

  Future<void> _remove() async {
    final ok = await showConfirmDialog(
      context,
      title: '¿Eliminar "${widget.editing!.name}"?',
      message: 'Si ya tiene movimientos, se archivará: dejará de aparecer pero tu historial se conserva.',
    );
    if (!ok || !mounted) return;
    final repo = ref.read(categoryRepositoryProvider);
    final result = await repo.remove(widget.editing!.id);
    if (!mounted) return;
    Navigator.pop(context);
    showAppSnackBar(
      widget.messenger,
      result == CategoryRemoval.archived ? 'Categoría archivada' : 'Categoría eliminada',
      onUndo: result == CategoryRemoval.archived
          ? () => repo.update(widget.editing!.copyWith(archived: false))
          : () => repo.add(widget.editing!),
    );
  }

  @override
  Widget build(BuildContext context) {
    final preview = _draft;
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
                      _isEditing ? 'Editar categoría' : 'Nueva categoría',
                      style: context.text.headlineSmall,
                    ),
                  ),
                  if (_isEditing)
                    IconButton(
                      tooltip: 'Eliminar categoría',
                      onPressed: _remove,
                      icon: Icon(Icons.delete_outline_rounded, color: context.colors.expense),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Center(
                child: TweenAnimationBuilder<double>(
                  key: ValueKey('$_icon$_color'),
                  tween: Tween(begin: 0.85, end: 1),
                  duration: AppDurations.medium,
                  curve: AppCurves.spring,
                  builder: (_, s, child) => Transform.scale(scale: s, child: child),
                  child: CategoryAvatar(category: preview, size: 72),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (!_isEditing) ...[
                SlidingSegmented<MovementKind>(
                  segments: const [
                    Segment(MovementKind.expense, 'Gasto'),
                    Segment(MovementKind.income, 'Ingreso'),
                  ],
                  selected: _kind,
                  onChanged: (k) => setState(() => _kind = k),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              TextFormField(
                controller: _name,
                autofocus: !_isEditing,
                maxLength: 40,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(labelText: 'Nombre', errorText: _nameError, counterText: ''),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Escribe un nombre' : null,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Ícono', style: context.text.titleSmall),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final entry in CategoryCatalog.icons.entries)
                    _Choice(
                      selected: entry.key == _icon,
                      semanticLabel: 'Ícono ${entry.key}',
                      onTap: () => setState(() => _icon = entry.key),
                      child: Icon(
                        entry.value,
                        size: 22,
                        color: entry.key == _icon ? Color(_color) : context.colors.textSecondary,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Color', style: context.text.titleSmall),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final c in CategoryCatalog.colors)
                    _Choice(
                      selected: c == _color,
                      semanticLabel: 'Color',
                      onTap: () => setState(() => _color = c),
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(color: Color(c), shape: BoxShape.circle),
                        child: c == _color
                            ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                            : null,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton(
                onPressed: _saving ? null : _save,
                child: Text(_isEditing ? 'Guardar cambios' : 'Crear categoría'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Choice extends StatelessWidget {
  const _Choice({
    required this.selected,
    required this.onTap,
    required this.child,
    required this.semanticLabel,
  });

  final bool selected;
  final VoidCallback onTap;
  final Widget child;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      label: semanticLabel,
      child: InkWell(
        onTap: () {
          Haptics.tap();
          onTap();
        },
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: AnimatedContainer(
          duration: AppDurations.fast,
          width: kMinTapTarget,
          height: kMinTapTarget,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? context.colors.surfaceHigh : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: selected ? context.scheme.primary : Colors.transparent, width: 2),
          ),
          child: child,
        ),
      ),
    );
  }
}
