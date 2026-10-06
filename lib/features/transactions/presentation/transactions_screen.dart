import 'package:flutter/material.dart';

import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/page_scaffold.dart';
import 'quick_add_sheet.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Movimientos',
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: EmptyState(
              icon: Icons.receipt_long_rounded,
              title: 'Tu historial está vacío',
              message: 'Aquí verás tus ingresos y gastos agrupados por día, con filtros por quincena y mes.',
              actionLabel: 'Agregar movimiento',
              onAction: () => showQuickAddSheet(context),
            ),
          ),
        ),
      ],
    );
  }
}
