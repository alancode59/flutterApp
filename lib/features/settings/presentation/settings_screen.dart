import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_palette.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../core/widgets/sliding_segmented.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/pressable.dart';
import '../../../core/widgets/section_header.dart';
import 'settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _run(BuildContext context, Future<void> Function() action) async {
    try {
      await action();
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No se pudo guardar el ajuste. Intenta de nuevo.')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return PageScaffold(
      title: 'Ajustes',
      slivers: [
        const SliverToBoxAdapter(child: SectionHeader(title: 'Tema')),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
            child: SlidingSegmented<ThemeMode>(
              height: 44,
              segments: const [
                Segment(ThemeMode.system, 'Sistema', icon: Icons.brightness_auto_rounded),
                Segment(ThemeMode.light, 'Claro', icon: Icons.light_mode_rounded),
                Segment(ThemeMode.dark, 'Oscuro', icon: Icons.dark_mode_rounded),
              ],
              selected: settings.themeMode,
              onChanged: (m) => _run(context, () => controller.setThemeMode(m)),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SectionHeader(title: 'Paleta de color')),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
          sliver: SliverList.separated(
            itemCount: AppPalette.all.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.xs),
            itemBuilder: (context, i) {
              final palette = AppPalette.all[i];
              return _PaletteTile(
                palette: palette,
                selected: palette.id == settings.palette,
                onTap: () => _run(context, () => controller.setPalette(palette.id)),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: SectionHeader(title: 'General')),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
          sliver: SliverToBoxAdapter(
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.slideshow_rounded),
                    title: const Text('Ver la bienvenida otra vez'),
                    trailing: Icon(Icons.chevron_right_rounded, color: context.colors.textSecondary),
                    onTap: () => _run(context, () async {
                      await controller.setOnboardingCompleted(false);
                      if (context.mounted) context.go(AppRoutes.onboarding);
                    }),
                  ),
                  const ListTile(
                    leading: Icon(Icons.shield_moon_rounded),
                    title: Text('Privacidad'),
                    subtitle: Text(
                      'Tus datos se guardan solo en este dispositivo, sin servidores ni cuentas.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PaletteTile extends StatelessWidget {
  const _PaletteTile({required this.palette, required this.selected, required this.onTap});

  final AppPalette palette;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = palette.of(Theme.of(context).brightness);

    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: Pressable(
        semanticLabel: 'Paleta ${palette.name}',
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppDurations.medium,
          curve: AppCurves.standard,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: context.scheme.surfaceContainer,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: selected ? context.scheme.primary : Colors.transparent, width: 2),
          ),
          child: Row(
            children: [
              _Swatches(colors: colors),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(palette.name, style: context.text.titleMedium),
                    const SizedBox(height: 2),
                    Text(palette.description, style: context.text.bodySmall),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: AppDurations.medium,
                transitionBuilder: (child, a) => ScaleTransition(scale: a, child: child),
                child: selected
                    ? Icon(
                        Icons.check_circle_rounded,
                        key: const ValueKey(true),
                        color: context.scheme.primary,
                      )
                    : Icon(Icons.circle_outlined, key: const ValueKey(false), color: context.scheme.outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Swatches extends StatelessWidget {
  const _Swatches({required this.colors});

  final PaletteColors colors;

  @override
  Widget build(BuildContext context) {
    Widget dot(Color c, {double size = 22}) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: c,
        shape: BoxShape.circle,
        border: Border.all(color: context.scheme.outline, width: 0.5),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(color: colors.background, borderRadius: BorderRadius.circular(AppRadius.md)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          dot(colors.accent, size: 26),
          const SizedBox(width: 4),
          dot(colors.income),
          const SizedBox(width: 4),
          dot(colors.expense),
        ],
      ),
    );
  }
}
