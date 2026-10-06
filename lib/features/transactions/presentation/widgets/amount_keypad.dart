import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_tokens.dart';
import '../../../../core/services/haptics.dart';

/// Teclado numérico propio: evita el teclado del sistema y permite capturar
/// un monto con pocos toques. Envía `0`–`9`, `.` o `⌫`.
class AmountKeypad extends StatelessWidget {
  const AmountKeypad({required this.onKey, required this.onClear, this.keyHeight = 56, super.key});

  static const backspace = '⌫';

  final ValueChanged<String> onKey;
  final VoidCallback onClear;
  final double keyHeight;

  static const _rows = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['.', '0', backspace],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final row in _rows)
          Row(
            children: [
              for (final key in row)
                Expanded(
                  child: _Key(
                    label: key,
                    height: keyHeight,
                    onTap: () => onKey(key),
                    onLongPress: key == backspace ? onClear : null,
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _Key extends StatelessWidget {
  const _Key({required this.label, required this.height, required this.onTap, this.onLongPress});

  final String label;
  final double height;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final isBackspace = label == AmountKeypad.backspace;
    final semantic = switch (label) {
      AmountKeypad.backspace => 'Borrar',
      '.' => 'Punto decimal',
      _ => label,
    };

    return Semantics(
      button: true,
      label: semantic,
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.md),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Haptics.tap();
              onTap();
            },
            onLongPress: onLongPress == null
                ? null
                : () {
                    Haptics.light();
                    onLongPress!();
                  },
            child: SizedBox(
              height: height,
              child: Center(
                child: isBackspace
                    ? Icon(Icons.backspace_outlined, color: context.scheme.onSurface)
                    : FittedBox(
                        child: Text(
                          label,
                          style: context.text.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
