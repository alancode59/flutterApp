import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_tokens.dart';

/// Pantalla con título grande que, al hacer scroll, se contrae a una barra
/// translúcida con desenfoque (estilo iOS).
class PageScaffold extends StatelessWidget {
  const PageScaffold({
    required this.title,
    required this.slivers,
    this.actions,
    this.leading,
    this.floatingActionButton,
    this.controller,
    super.key,
  });

  final String title;
  final List<Widget> slivers;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? floatingActionButton;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final canPop = ModalRoute.of(context)?.impliesAppBarDismissal ?? false;

    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: CustomScrollView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _LargeTitleHeader(
              title: title,
              topPadding: padding.top,
              leading: leading ?? (canPop ? const BackButton() : null),
              actions: actions ?? const [],
              background: context.scheme.surface,
              hairline: context.scheme.outlineVariant,
              largeStyle: context.text.headlineLarge!,
              smallStyle: context.text.titleMedium!.copyWith(fontSize: 17),
            ),
          ),
          ...slivers,
          SliverToBoxAdapter(child: SizedBox(height: padding.bottom + AppSpacing.xl)),
        ],
      ),
    );
  }
}

class _LargeTitleHeader extends SliverPersistentHeaderDelegate {
  _LargeTitleHeader({
    required this.title,
    required this.topPadding,
    required this.leading,
    required this.actions,
    required this.background,
    required this.hairline,
    required this.largeStyle,
    required this.smallStyle,
  });

  final String title;
  final double topPadding;
  final Widget? leading;
  final List<Widget> actions;
  final Color background;
  final Color hairline;
  final TextStyle largeStyle;
  final TextStyle smallStyle;

  static const _toolbar = 52.0;
  static const _large = 48.0;

  @override
  double get minExtent => topPadding + _toolbar;

  @override
  double get maxExtent => topPadding + _toolbar + _large;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final collapsed = Curves.easeIn.transform(((t - 0.6) / 0.4).clamp(0.0, 1.0));

    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24 * collapsed, sigmaY: 24 * collapsed),
            child: ColoredBox(color: background.withValues(alpha: 1 - 0.18 * collapsed)),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Opacity(
            opacity: collapsed,
            child: Container(height: 0.5, color: hairline),
          ),
        ),
        // Barra superior: regresar, título pequeño y acciones.
        Positioned(
          top: topPadding,
          left: 0,
          right: 0,
          height: _toolbar,
          child: NavigationToolbar(
            leading: leading,
            middle: Opacity(
              opacity: collapsed,
              child: Text(title, style: smallStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...actions,
                const SizedBox(width: AppSpacing.sm),
              ],
            ),
            middleSpacing: AppSpacing.xs,
          ),
        ),
        // Título grande que sube y se desvanece.
        Positioned(
          left: AppSpacing.page,
          right: AppSpacing.page,
          bottom: 6,
          child: IgnorePointer(
            child: Opacity(
              opacity: (1 - t * 1.6).clamp(0.0, 1.0),
              child: Transform.translate(
                offset: Offset(0, -12 * t),
                child: Semantics(
                  header: true,
                  child: Text(title, style: largeStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(_LargeTitleHeader old) =>
      old.title != title ||
      old.topPadding != topPadding ||
      old.leading != leading ||
      old.actions != actions ||
      old.background != background ||
      old.largeStyle != largeStyle;
}
