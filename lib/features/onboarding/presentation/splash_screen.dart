import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/app_logo.dart';
import '../../settings/presentation/settings_controller.dart';

/// Pantalla de arranque: las barras del logo crecen y aparece el nombre.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller.isAnimating || _controller.isCompleted) return;
    if (MediaQuery.disableAnimationsOf(context)) _controller.duration = const Duration(milliseconds: 300);
    _controller.forward().whenComplete(_continue);
  }

  void _continue() {
    if (!mounted) return;
    final done = ref.read(settingsControllerProvider).onboardingCompleted;
    context.go(done ? AppRoutes.home : AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logoIn = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.45, curve: Curves.easeOutBack),
    );
    final bars = CurvedAnimation(parent: _controller, curve: const Interval(0.15, 0.8));
    final text = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 0.85, curve: Curves.easeOutCubic),
    );

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: 0.6 + 0.4 * logoIn.value,
                child: Opacity(
                  opacity: logoIn.value.clamp(0.0, 1.0),
                  child: AppLogo(size: 88, progress: bars.value),
                ),
              ),
              const SizedBox(height: 24),
              Opacity(
                opacity: text.value,
                child: Transform.translate(
                  offset: Offset(0, 12 * (1 - text.value)),
                  child: Column(
                    children: [
                      Text('Finanzas', style: context.text.headlineMedium),
                      const SizedBox(height: 4),
                      Text(
                        'Tu dinero, claro',
                        style: context.text.bodyMedium?.copyWith(color: context.colors.textSecondary),
                      ),
                    ],
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
