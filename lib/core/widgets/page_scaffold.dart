import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';

/// Pantalla con título grande que se contrae al hacer scroll (estilo iOS/Revolut).
class PageScaffold extends StatelessWidget {
  const PageScaffold({
    required this.title,
    required this.slivers,
    this.actions,
    this.leading,
    this.floatingActionButton,
    super.key,
  });

  final String title;
  final List<Widget> slivers;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: [
          SliverAppBar.large(
            title: Text(title),
            leading: leading,
            actions: [
              ...?actions,
              const SizedBox(width: AppSpacing.xs),
            ],
          ),
          ...slivers,
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
        ],
      ),
    );
  }
}
