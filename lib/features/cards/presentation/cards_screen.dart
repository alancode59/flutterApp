import 'package:flutter/material.dart';

import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/page_scaffold.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Tarjetas',
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: EmptyState(
              icon: Icons.credit_card_rounded,
              title: 'Agrega tu primera tarjeta',
              message: 'Lleva el corte proyectado, la fecha límite de pago, tus MSI y la utilización de tu crédito.',
              actionLabel: 'Agregar tarjeta',
              onAction: () => ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(content: Text('Las tarjetas llegan en la Fase 3.'))),
            ),
          ),
        ),
      ],
    );
  }
}
