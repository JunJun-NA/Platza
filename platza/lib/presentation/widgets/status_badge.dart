import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/enums/enums.dart';

/// 植物の状態を表示するバッジ
///
/// [variant] で表示スタイルを切り替え:
/// - [StatusBadgeVariant.dot]   ドットインジケーター + テキスト
/// - [StatusBadgeVariant.chip]  背景色付きのチップ
/// - [StatusBadgeVariant.icon]  絵文字のみ
enum StatusBadgeVariant { dot, chip, icon }

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.status,
    this.variant = StatusBadgeVariant.dot,
  });

  final PlantStatus status;
  final StatusBadgeVariant variant;

  Color get _color {
    return switch (status) {
      PlantStatus.happy => AppColors.statusHappy,
      PlantStatus.thirsty => AppColors.statusThirsty,
      PlantStatus.wilting => AppColors.statusWilting,
      PlantStatus.blooming => AppColors.statusBlooming,
    };
  }

  Color get _bgColor {
    return switch (status) {
      PlantStatus.happy => AppColors.statusHappyBg,
      PlantStatus.thirsty => AppColors.statusThirstyBg,
      PlantStatus.wilting => AppColors.statusWiltingBg,
      PlantStatus.blooming => AppColors.statusBloomingBg,
    };
  }

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      StatusBadgeVariant.dot => _buildDot(context),
      StatusBadgeVariant.chip => _buildChip(context),
      StatusBadgeVariant.icon => Text(status.emoji, style: const TextStyle(fontSize: 16)),
    };
  }

  Widget _buildDot(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          status.label,
          style: AppTypography.badge.copyWith(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(status.emoji, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: AppSpacing.xs),
          Text(
            status.label,
            style: AppTypography.badge.copyWith(color: _color),
          ),
        ],
      ),
    );
  }
}
