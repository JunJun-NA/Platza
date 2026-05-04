import 'package:flutter/material.dart';

/// 部屋シーンの背景画像。画面全体に敷く。
class RoomBackground extends StatelessWidget {
  const RoomBackground({super.key});

  static const String _assetPath = 'assets/backgrounds/image.png';

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _assetPath,
      fit: BoxFit.cover,
      alignment: Alignment.bottomCenter,
    );
  }
}
