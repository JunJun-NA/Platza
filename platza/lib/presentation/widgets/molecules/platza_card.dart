import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';

/// 統一的なカードウィジェット
///
/// テーマの CardTheme を適用しつつ、
/// オプションで onTap・パディングをカスタマイズできる。
class PlatzaCard extends StatelessWidget {
  const PlatzaCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding ?? AppSpacing.cardPadding,
      child: child,
    );

    return Card(
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              borderRadius: AppRadius.all16,
              child: content,
            )
          : content,
    );
  }
}
