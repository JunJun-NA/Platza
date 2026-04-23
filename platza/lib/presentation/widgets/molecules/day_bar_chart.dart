import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/presentation/widgets/molecules/platza_card.dart';

/// 週間（または任意期間の）活動数をバーチャートで表示する widget
///
/// [dailyActivity] の長さ分のバーを等間隔で描画。各バーの上にカウント、
/// 下にラベル（[dayLabels]）を表示。`statistics` の「今週のお世話」で使用。
class DayBarChart extends StatelessWidget {
  const DayBarChart({
    super.key,
    required this.dailyActivity,
    this.dayLabels = const ['月', '火', '水', '木', '金', '土', '日'],
    this.height = 140,
    this.maxBarHeight = 80,
  });

  final List<int> dailyActivity;
  final List<String> dayLabels;
  final double height;
  final double maxBarHeight;

  @override
  Widget build(BuildContext context) {
    final maxCount = dailyActivity.isEmpty
        ? 1
        : dailyActivity.reduce((a, b) => a > b ? a : b);
    final effectiveMax = maxCount == 0 ? 1 : maxCount;
    final barCount = dayLabels.length;

    return PlatzaCard(
      child: SizedBox(
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(barCount, (index) {
            final count =
                index < dailyActivity.length ? dailyActivity[index] : 0;
            final barHeight = (count / effectiveMax) * maxBarHeight;

            return Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (count > 0)
                      Text(
                        '$count',
                        style: AppTypography.label.copyWith(
                          color: AppColors.textSubtle,
                        ),
                      ),
                    const SizedBox(height: AppSpacing.xxs),
                    Container(
                      height: count > 0 ? barHeight : 4,
                      decoration: BoxDecoration(
                        color: count > 0
                            ? AppColors.primaryGreen
                            : AppColors.borderLight,
                        borderRadius: AppRadius.all8,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      dayLabels[index],
                      style: AppTypography.label.copyWith(
                        color: AppColors.textSubtlest,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
