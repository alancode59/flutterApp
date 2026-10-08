import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../core/widgets/sliding_segmented.dart';
import '../../../core/widgets/async_reveal.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/skeleton.dart';
import '../../transactions/domain/movement.dart';
import '../data/category_repository.dart';
import '../domain/category.dart';
import 'category_editor_sheet.dart';
import 'category_providers.dart';
import 'widgets/category_avatar.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  MovementKind _kind = MovementKind.expense;

  @override
  Widget build(BuildContext context) {
    final all = ref.watch(allCategoriesProvider);

    return PageScaffold(
      title: 'Categorías',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showCategoryEditor(context, kind: _kind),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nueva'),
      ),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
            child: SlidingSegmented<MovementKind>(
              segments: const [
                Segment(MovementKind.expense, 'Gastos'),
                Segment(MovementKind.income, 'Ingresos'),
              ],
              selected: _kind,
              onChanged: (k) => setState(() => _kind = k),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AsyncReveal<List<Category>>(
            value: all,
            skeleton: const Padding(
              padding: EdgeInsets.all(AppSpacing.page),
              child: Card(child: SkeletonList(count: 6)),
            ),
            builder: (list) {
              final ofKind = list.where((c) => c.kind == _kind);
              final active = ofKind.where((c) => !c.archived).toList();
              final archived = ofKind.where((c) => c.archived).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.md),
                  _Group(
                    key: ValueKey('active-$_kind'),
                    children: [
                      for (final c in active)
                        ListTile(
                          leading: CategoryAvatar(category: c, size: 40),
                          title: Text(c.name),
                          trailing: Icon(Icons.chevron_right_rounded, color: context.colors.textSecondary),
                          onTap: () => showCategoryEditor(context, editing: c),
                        ),
                    ],
                  ),
                  if (archived.isNotEmpty) ...[
                    const SectionHeader(title: 'Archivadas'),
                    _Group(
                      key: ValueKey('archived-$_kind'),
                      children: [
                        for (final c in archived)
                          ListTile(
                            leading: Opacity(opacity: 0.5, child: CategoryAvatar(category: c, size: 40)),
                            title: Text(c.name),
                            subtitle: const Text('No aparece al registrar movimientos'),
                            trailing: TextButton(
                              onPressed: () =>
                                  ref.read(categoryRepositoryProvider).update(c.copyWith(archived: false)),
                              child: const Text('Restaurar'),
                            ),
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 88),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
          child: Column(
            children: children
                .animate(interval: 25.ms)
                .fadeIn(duration: AppDurations.medium)
                .slideX(begin: 0.04, curve: AppCurves.standard),
          ),
        ),
      ),
    );
  }
}
