import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_tokens.dart';
import 'empty_state.dart';

/// Muestra [skeleton] mientras [value] carga y luego revela el contenido con
/// una transición suave. La primera vez espera al menos [minDuration] para
/// que el esqueleto no parpadee cuando la base responde en milisegundos.
class AsyncReveal<T> extends StatefulWidget {
  const AsyncReveal({
    required this.value,
    required this.skeleton,
    required this.builder,
    this.minDuration = const Duration(milliseconds: 650),
    super.key,
  });

  final AsyncValue<T> value;
  final Widget skeleton;
  final Widget Function(T data) builder;
  final Duration minDuration;

  @override
  State<AsyncReveal<T>> createState() => _AsyncRevealState<T>();
}

class _AsyncRevealState<T> extends State<AsyncReveal<T>> {
  Timer? _timer;
  bool _minElapsed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_timer != null || _minElapsed) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _minElapsed = true;
      return;
    }
    _timer = Timer(widget.minDuration, () {
      if (mounted) setState(() => _minElapsed = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    final Widget child;
    if (_minElapsed && value.hasValue) {
      child = KeyedSubtree(key: const ValueKey('data'), child: widget.builder(value.requireValue));
    } else if (_minElapsed && value.hasError) {
      child = const EmptyState(
        key: ValueKey('error'),
        compact: true,
        icon: Icons.error_outline_rounded,
        title: 'No se pudieron cargar los datos',
        message: 'Cierra y vuelve a abrir la app. Si continúa, revisa el espacio del dispositivo.',
      );
    } else {
      child = KeyedSubtree(key: const ValueKey('skeleton'), child: widget.skeleton);
    }

    return AnimatedSwitcher(
      duration: AppDurations.slow,
      switchInCurve: AppCurves.standard,
      switchOutCurve: Curves.easeIn,
      layoutBuilder: (current, previous) =>
          Stack(alignment: Alignment.topCenter, children: [...previous, ?current]),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 0.02), end: Offset.zero).animate(animation),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
