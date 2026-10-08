import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_tokens.dart';
import '../../../../core/services/haptics.dart';

/// Cuadrícula para elegir un día del mes (1–31).
Future<int?> showDayPicker(BuildContext context, {required String title, String? subtitle, int? selected}) {
  return showModalBottomSheet<int>(
    context: context,
    useRootNavigator: true,
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.page, 0, AppSpacing.page, AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.text.titleLarge),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle, style: context.text.bodySmall),
            ],
            const SizedBox(height: AppSpacing.md),
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (var d = 1; d <= 31; d++)
                  _Day(
                    day: d,
                    selected: d == selected,
                    onTap: () {
                      Haptics.tap();
                      Navigator.pop(context, d);
                    },
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text('En meses más cortos se usa el último día del mes.', style: context.text.bodySmall),
          ],
        ),
      ),
    ),
  );
}

class _Day extends StatelessWidget {
  const _Day({required this.day, required this.selected, required this.onTap});

  final int day;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: 'Día $day',
      excludeSemantics: true,
      child: Material(
        color: selected ? context.scheme.primary : context.colors.surfaceHigh,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Center(
            child: Text(
              '$day',
              style: context.text.labelLarge?.copyWith(
                fontSize: 15,
                color: selected ? context.scheme.onPrimary : context.scheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
