import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/enums/enums.dart';

/// お世話種別の絵文字を背景色付きで表示する小さなコンテナ
///
/// care_log / care_calendar 等でログ行の先頭アイコンとして使用。
/// 背景色は `careType` 固有の色を 15% 透過したもの。
class CareTypeIconContainer extends StatelessWidget {
  const CareTypeIconContainer({
    super.key,
    required this.careType,
    this.size = 40,
  });

  final CareType careType;
  final double size;

  Color get _tint {
    return switch (careType) {
      CareType.water => AppColors.careWater,
      CareType.fertilize => AppColors.careFertilize,
      CareType.sunlight => AppColors.careSunlight,
      CareType.repot => AppColors.careRepot,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _tint.withValues(alpha: 0.15),
        borderRadius: AppRadius.all8,
      ),
      child: Center(
        child: Text(careType.emoji, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
