import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../core/widgets/page_scaffold.dart';

/// Menú secundario (ícono de perfil en Inicio): secciones fuera de la barra inferior.
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final planned = [
      (Icons.handshake_rounded, 'Deudas', 'Lo que debo y me deben', 4),
      (Icons.pie_chart_rounded, 'Presupuesto', 'Límite por quincena y categoría', 5),
      (Icons.cloud_download_rounded, 'Respaldo', 'Exportar e importar tus datos', 7),
    ];

    return PageScaffold(
      title: 'Más',
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
          sliver: SliverList.list(
            children: [
              _Group(
                children: [
                  _MenuTile(
                    icon: Icons.autorenew_rounded,
                    title: 'Recurrentes',
                    subtitle: 'Quincena, renta, servicios y suscripciones',
                    onTap: () => context.push(AppRoutes.recurring),
                  ),
                  _MenuTile(
                    icon: Icons.category_rounded,
                    title: 'Categorías',
                    subtitle: 'Íconos y colores personalizados',
                    onTap: () => context.push(AppRoutes.categories),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _Group(
                children: [
                  for (final (icon, title, subtitle, phase) in planned)
                    _MenuTile(icon: icon, title: title, subtitle: subtitle, badge: 'Fase $phase'),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _Group(
                children: [
                  _MenuTile(
                    icon: Icons.settings_rounded,
                    title: 'Ajustes',
                    subtitle: 'Tema, colores y seguridad',
                    onTap: () => context.push(AppRoutes.settings),
                  ),
                ],
              ),
            ].animate(interval: 60.ms).fadeIn(duration: AppDurations.medium).slideY(begin: 0.05),
          ),
        ),
      ],
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
        child: Column(children: children),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.icon, required this.title, required this.subtitle, this.badge, this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;

    return ListTile(
      enabled: enabled,
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: context.scheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(icon, size: 22, color: context.scheme.primary),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: enabled
          ? Icon(Icons.chevron_right_rounded, color: context.colors.textSecondary)
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: AppSpacing.xxs),
              decoration: BoxDecoration(
                color: context.colors.surfaceHigh,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(badge ?? 'Pronto', style: context.text.labelSmall),
            ),
    );
  }
}
