import 'package:flutter/material.dart';

/// 部屋背景の上に重ねる自然光オーバーレイ。
///
/// 窓は背景画像の左側にある想定で、左上から右下にかけて
/// 暖かい光が差し込むイメージのグラデーションを乗せる。
/// 将来的には時間帯/季節で色味を動的に変えられるよう拡張予定。
class NaturalLightOverlay extends StatelessWidget {
  const NaturalLightOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFE0B2).withValues(alpha: 0.25),
            Colors.transparent,
            Colors.transparent,
            const Color(0xFF8D6E63).withValues(alpha: 0.10),
          ],
          stops: const [0.0, 0.35, 0.7, 1.0],
        ),
      ),
    );
  }
}
