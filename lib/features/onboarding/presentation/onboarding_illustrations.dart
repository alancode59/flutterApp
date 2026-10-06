import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../app/theme/app_typography.dart';

/// Ilustraciones de la bienvenida, hechas con widgets (sin imágenes) para que
/// respeten la paleta y el modo claro/oscuro. Se animan cuando [active] es true.

class TransactionsIllustration extends StatelessWidget {
  const TransactionsIllustration({required this.active, super.key});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final rows = [
      (Icons.shopping_basket_rounded, 'Supermercado', 'Débito', '-\$486.50', context.colors.expense),
      (Icons.work_rounded, 'Quincena', 'Nómina', '+\$14,250.00', context.colors.income),
      (Icons.local_cafe_rounded, 'Café', 'Efectivo', '-\$65.00', context.colors.expense),
    ];

    return Container(
      width: 320,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: context.scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (i, (icon, title, method, amount, color)) in rows.indexed)
            Padding(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: context.colors.surfaceHigh,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Icon(icon, color: context.scheme.primary, size: 22),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: context.text.titleSmall),
                            Text(method, style: context.text.bodySmall),
                          ],
                        ),
                      ),
                      Text(
                        amount,
                        style: AppTypography.amount(15, color: color, weight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
                .animate(target: active ? 1 : 0)
                .fadeIn(delay: (120 * i).ms, duration: AppDurations.slow)
                .slideX(begin: 0.25, curve: AppCurves.emphasized, duration: AppDurations.slow),
        ],
      ),
    ).animate(target: active ? 1 : 0).scale(begin: const Offset(0.94, 0.94), curve: AppCurves.standard);
  }
}

class CardsIllustration extends StatelessWidget {
  const CardsIllustration({required this.active, super.key});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
                offset: const Offset(-18, -34),
                child: Transform.rotate(
                  angle: -8 * math.pi / 180,
                  child: const _MiniCard(color: Color(0xFF24242C), bank: 'Banco Norte', last4: '9012'),
                ),
              )
              .animate(target: active ? 1 : 0)
              .fadeIn(delay: 80.ms, duration: AppDurations.slow)
              .slideY(begin: 0.3, curve: AppCurves.emphasized, duration: 600.ms),
          Transform.translate(
                offset: const Offset(16, 30),
                child: Transform.rotate(
                  angle: 4 * math.pi / 180,
                  child: const _MiniCard(color: Color(0xFF1D4ED8), bank: 'Banco Azul', last4: '4821'),
                ),
              )
              .animate(target: active ? 1 : 0)
              .fadeIn(delay: 200.ms, duration: AppDurations.slow)
              .slideY(begin: 0.4, curve: AppCurves.emphasized, duration: 650.ms),
        ],
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({required this.color, required this.bank, required this.last4});

  final Color color;
  final String bank;
  final String last4;

  @override
  Widget build(BuildContext context) {
    const onCard = Colors.white;
    return Container(
      width: 250,
      height: 156,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 24, offset: const Offset(0, 12)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(bank, style: context.text.titleSmall?.copyWith(color: onCard)),
              const Spacer(),
              const Icon(Icons.contactless_rounded, color: onCard, size: 22),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: 34,
            height: 26,
            decoration: BoxDecoration(color: const Color(0xFFD9C27A), borderRadius: BorderRadius.circular(6)),
          ),
          const Spacer(),
          Text(
            '••••  $last4',
            style: AppTypography.amount(
              16,
              color: onCard,
              weight: FontWeight.w600,
            ).copyWith(letterSpacing: 1.5),
          ),
        ],
      ),
    );
  }
}

class BudgetIllustration extends StatelessWidget {
  const BudgetIllustration({required this.active, super.key});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final warning = context.colors.warning;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: 176,
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: active ? 0.8 : 0),
            duration: active ? 1100.ms : Duration.zero,
            curve: AppCurves.emphasized,
            builder: (context, v, _) => Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: v,
                  strokeWidth: 16,
                  strokeCap: StrokeCap.round,
                  color: Color.lerp(context.scheme.primary, warning, (v / 0.8).clamp(0, 1)),
                  backgroundColor: context.colors.surfaceHigh,
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(v * 100).round()} %',
                        style: AppTypography.amount(38, color: context.scheme.onSurface),
                      ),
                      Text('del presupuesto', style: context.text.labelMedium),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: context.scheme.surfaceContainer,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: warning.withValues(alpha: 0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_active_rounded, color: warning, size: 20),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Llevas el 80 % de tu presupuesto',
                    style: context.text.labelLarge?.copyWith(fontSize: 13),
                  ),
                ],
              ),
            )
            .animate(target: active ? 1 : 0)
            .fadeIn(delay: 900.ms, duration: AppDurations.medium)
            .slideY(begin: 0.5, curve: AppCurves.spring, duration: AppDurations.slow),
      ],
    );
  }
}

class PrivacyIllustration extends StatelessWidget {
  const PrivacyIllustration({required this.active, super.key});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final chips = [
      (Icons.wifi_off_rounded, 'Sin internet'),
      (Icons.face_rounded, 'Face ID'),
      (Icons.cloud_download_rounded, 'Respaldo'),
    ];

    Widget ring(double size, double alpha) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.scheme.primary.withValues(alpha: alpha),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (active && !reduceMotion)
                ring(180, 0.08)
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(begin: const Offset(0.85, 0.85), duration: 1400.ms, curve: Curves.easeInOut),
              ring(130, 0.14),
              Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(color: context.scheme.primary, shape: BoxShape.circle),
                    child: Icon(Icons.lock_rounded, size: 40, color: context.scheme.onPrimary),
                  )
                  .animate(target: active ? 1 : 0)
                  .scale(begin: const Offset(0.6, 0.6), curve: AppCurves.spring, duration: AppDurations.slow),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          alignment: WrapAlignment.center,
          children: [
            for (final (i, (icon, label)) in chips.indexed)
              Chip(
                    avatar: Icon(icon, size: 18, color: context.scheme.primary),
                    label: Text(label),
                  )
                  .animate(target: active ? 1 : 0)
                  .fadeIn(delay: (250 + 100 * i).ms, duration: AppDurations.medium)
                  .slideY(begin: 0.4, curve: AppCurves.standard),
          ],
        ),
      ],
    );
  }
}
