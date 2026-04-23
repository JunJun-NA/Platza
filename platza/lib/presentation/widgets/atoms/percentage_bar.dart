import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';

/// 比率を 2 色のレイヤーで表示するシンプルなバー
///
/// 背景に薄いトラック（[trackColor]）を敷き、上にアクティブ部分
/// （[activeColor] × [ratio] の幅）を重ねる。`statistics` のケア種別内訳などで利用。
class PercentageBar extends StatelessWidget {
  const PercentageBar({
    super.key,
    required this.ratio,
    required this.activeColor,
    required this.trackColor,
    this.height = 20,
  });

  /// 0.0 〜 1.0
  final double ratio;
  final Color activeColor;
  final Color trackColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final clamped = ratio.clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: AppRadius.all8,
      child: Stack(
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              color: trackColor,
              borderRadius: AppRadius.all8,
            ),
          ),
          FractionallySizedBox(
            widthFactor: clamped,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: AppRadius.all8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
