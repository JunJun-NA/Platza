import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';

/// セクションヘッダー
///
/// 設定画面やリスト画面のセクション区切りに使用。
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.action,
  });

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTypography.heading.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}
