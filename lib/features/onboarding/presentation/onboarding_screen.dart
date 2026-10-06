import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_tokens.dart';
import '../../../core/services/haptics.dart';
import '../../settings/presentation/settings_controller.dart';
import 'onboarding_illustrations.dart';

class _Slide {
  const _Slide({required this.title, required this.body, required this.illustration});

  final String title;
  final String body;
  final Widget Function(bool active) illustration;
}

final _slides = [
  _Slide(
    title: 'Tu dinero, claro y en un solo lugar',
    body: 'Registra ingresos y gastos en segundos y mira cuánto te queda en cada quincena.',
    illustration: (a) => TransactionsIllustration(active: a),
  ),
  _Slide(
    title: 'Tus tarjetas bajo control',
    body: 'Ve de cuánto será tu corte, la fecha límite de pago y tus compras a meses sin intereses.',
    illustration: (a) => CardsIllustration(active: a),
  ),
  _Slide(
    title: 'Un presupuesto que te avisa',
    body:
        'Define un límite por quincena y recibe alertas al 80 % y al 100 %, además de recordatorios de pago.',
    illustration: (a) => BudgetIllustration(active: a),
  ),
  _Slide(
    title: 'Privado y sin conexión',
    body: 'Todo se guarda en tu dispositivo. Protégelo con Face ID y haz respaldos cuando quieras.',
    illustration: (a) => PrivacyIllustration(active: a),
  ),
];

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;
  bool _finishing = false;

  bool get _isLast => _page == _slides.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    if (_finishing) return;
    setState(() => _finishing = true);
    try {
      await ref.read(settingsControllerProvider.notifier).setOnboardingCompleted(true);
      unawaited(Haptics.success());
      if (mounted) context.go(AppRoutes.home);
    } catch (_) {
      if (!mounted) return;
      setState(() => _finishing = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No se pudo guardar. Intenta de nuevo.')));
    }
  }

  void _next() {
    if (_isLast) {
      _finish();
      return;
    }
    _pageController.nextPage(duration: AppDurations.slow, curve: AppCurves.standard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.xs, top: AppSpacing.xxs),
                child: AnimatedOpacity(
                  opacity: _isLast ? 0 : 1,
                  duration: AppDurations.medium,
                  child: TextButton(onPressed: _isLast ? null : _finish, child: const Text('Omitir')),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (i) {
                  Haptics.tap();
                  setState(() => _page = i);
                },
                itemBuilder: (context, i) => _SlideView(slide: _slides[i], active: i == _page),
              ),
            ),
            _PageDots(count: _slides.length, current: _page),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.page,
                AppSpacing.xl,
                AppSpacing.page,
                AppSpacing.md,
              ),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _finishing ? null : _next,
                  child: AnimatedSwitcher(
                    duration: AppDurations.fast,
                    child: Text(_isLast ? 'Comenzar' : 'Siguiente', key: ValueKey(_isLast)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideView extends StatelessWidget {
  const _SlideView({required this.slide, required this.active});

  final _Slide slide;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: (constraints.maxHeight * 0.55).clamp(220.0, 340.0),
                child: Center(child: ExcludeSemantics(child: slide.illustration(active))),
              ),
              const SizedBox(height: AppSpacing.xl),
              Semantics(
                header: true,
                child: Text(slide.title, textAlign: TextAlign.center, style: context.text.headlineMedium),
              ),
              const SizedBox(height: AppSpacing.sm),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Text(
                  slide.body,
                  textAlign: TextAlign.center,
                  style: context.text.bodyLarge?.copyWith(color: context.colors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Página ${current + 1} de $count',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++)
            AnimatedContainer(
              duration: AppDurations.medium,
              curve: AppCurves.standard,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == current ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == current ? context.scheme.primary : context.scheme.outline,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
        ],
      ),
    );
  }
}
