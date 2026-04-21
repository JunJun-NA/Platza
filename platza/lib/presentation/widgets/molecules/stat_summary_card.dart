import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/presentation/widgets/molecules/platza_card.dart';

/// 統計サマリーを 1 ボックスで表示するカード
///
/// emoji（上）+ 強調された値（中）+ 補助ラベル（下）の縦積み。
/// `statistics` の画面ヘッダに 3 つ横並びで配置する想定。
class StatSummaryCard extends StatelessWidget {
  const StatSummaryCard({
    super.key,
    required this.emoji,
    required this.value,
    required this.label,
  });

  final String emoji;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return PlatzaCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.md,
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            value,
            style: AppTypography.subtitle.copyWith(
              color: AppColors.textDefault,
            ),
          ),
          const SizedBox(height: AppSpacing.xxxs),
          Text(
            label,
            style: AppTypography.label.copyWith(
              color: AppColors.textSubtlest,
            ),
          ),
        ],
      ),
    );
  }
}
