import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/enums/enums.dart';

/// お世話アクションボタン
///
/// 水やり・肥料・日当たり・植え替えの各アクション用ボタン。
/// [CareType] に応じてアイコン・カラーが自動設定される。
class CareActionButton extends StatelessWidget {
  const CareActionButton({
    super.key,
    required this.careType,
    required this.onTap,
    this.enabled = true,
  });

  final CareType careType;
  final VoidCallback onTap;
  final bool enabled;

  Color get _color {
    return switch (careType) {
      CareType.water => AppColors.careWater,
      CareType.fertilize => AppColors.careFertilize,
      CareType.sunlight => AppColors.careSunlight,
      CareType.repot => AppColors.careRepot,
    };
  }

  Color get _bgColor {
    return switch (careType) {
      CareType.water => AppColors.careWaterLight,
      CareType.fertilize => AppColors.careFertilizeLight,
      CareType.sunlight => AppColors.careSunlightLight,
      CareType.repot => AppColors.careRepotLight,
    };
  }

  IconData get _icon {
    return switch (careType) {
      CareType.water => Icons.water_drop,
      CareType.fertilize => Icons.eco,
      CareType.sunlight => Icons.wb_sunny,
      CareType.repot => Icons.yard,
    };
  }

  @override
  Widget build(BuildContext context) {
    final opacity = enabled ? 1.0 : 0.4;

    return Opacity(
      opacity: opacity,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSpacing.actionButtonSize,
              height: AppSpacing.actionButtonSize,
              decoration: BoxDecoration(
                color: _bgColor,
                borderRadius: AppRadius.all16,
                border: Border.all(
                  color: _color.withValues(alpha: 0.3),
                ),
              ),
              child: Icon(_icon, color: _color, size: AppSpacing.iconSizeLg),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              careType.label,
              style: AppTypography.label.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
