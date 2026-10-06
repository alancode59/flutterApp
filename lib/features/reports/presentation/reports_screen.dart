import 'package:flutter/material.dart';

import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/page_scaffold.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScaffold(
      title: 'Análisis',
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: EmptyState(
              icon: Icons.insights_rounded,
              title: 'Sin datos para analizar',
              message:
                  'Cuando registres movimientos verás tus gastos por categoría, tendencias y cuánto ahorras.',
            ),
          ),
        ),
      ],
    );
  }
}
