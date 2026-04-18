import 'dart:math';

import 'package:flutter/material.dart';
import 'package:platza/domain/enums/enums.dart';

/// お世話アクション後のリアクションアニメーションオーバーレイ
///
/// 水やり: 青い水滴
/// 肥料: キラキラ
/// その他: ハートや星
class CareReactionOverlay extends StatefulWidget {
  const CareReactionOverlay({
    super.key,
    required this.careType,
    required this.onComplete,
  });

  final CareType careType;
  final VoidCallback onComplete;

  @override
  State<CareReactionOverlay> createState() => _CareReactionOverlayState();
}

class _CareReactionOverlayState extends State<CareReactionOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // パーティクルを生成
    _particles = List.generate(8, (_) => _generateParticle());

    _controller.forward().then((_) {
      widget.onComplete();
    });
  }

  _Particle _generateParticle() {
    return _Particle(
      startX: 0.3 + _random.nextDouble() * 0.4,
      startY: 0.3 + _random.nextDouble() * 0.3,
      dx: (_random.nextDouble() - 0.5) * 0.6,
      dy: -0.2 - _random.nextDouble() * 0.4,
      delay: _random.nextDouble() * 0.3,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          size: Size.infinite,
          painter: _ReactionPainter(
            particles: _particles,
            progress: _controller.value,
            careType: widget.careType,
          ),
        );
      },
    );
  }
}

/// パーティクルデータ
class _Particle {
  const _Particle({
    required this.startX,
    required this.startY,
    required this.dx,
    required this.dy,
    required this.delay,
  });

  final double startX;
  final double startY;
  final double dx;
  final double dy;
  final double delay;
}

/// リアクションエフェクトの描画
class _ReactionPainter extends CustomPainter {
  _ReactionPainter({
    required this.particles,
    required this.progress,
    required this.careType,
  });

  final List<_Particle> particles;
  final double progress;
  final CareType careType;

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      // パーティクルごとの遅延を考慮した進行度
      final adjustedProgress = ((progress - particle.delay) / (1.0 - particle.delay))
          .clamp(0.0, 1.0);

      if (adjustedProgress <= 0) continue;

      // フェードアウト
      final opacity = (1.0 - adjustedProgress).clamp(0.0, 1.0);
      if (opacity <= 0) continue;

      final x = (particle.startX + particle.dx * adjustedProgress) * size.width;
      final y = (particle.startY + particle.dy * adjustedProgress) * size.height;
      final particleSize = 6.0 * (1.0 - adjustedProgress * 0.5);

      final paint = Paint()..color = _getColor().withValues(alpha: opacity);

      switch (careType) {
        case CareType.water:
          // 水滴: 楕円形
          canvas.drawOval(
            Rect.fromCenter(
              center: Offset(x, y),
              width: particleSize * 0.7,
              height: particleSize,
            ),
            paint,
          );
        case CareType.fertilize:
          // キラキラ: ダイヤ形
          final path = Path()
            ..moveTo(x, y - particleSize)
            ..lineTo(x + particleSize * 0.5, y)
            ..lineTo(x, y + particleSize)
            ..lineTo(x - particleSize * 0.5, y)
            ..close();
          canvas.drawPath(path, paint);
        case CareType.sunlight:
          // 星形: 小さな円
          canvas.drawCircle(Offset(x, y), particleSize * 0.5, paint);
        case CareType.repot:
          // ハート風: 2つの円を重ねる
          canvas.drawCircle(
            Offset(x - particleSize * 0.2, y - particleSize * 0.1),
            particleSize * 0.4,
            paint,
          );
          canvas.drawCircle(
            Offset(x + particleSize * 0.2, y - particleSize * 0.1),
            particleSize * 0.4,
            paint,
          );
      }
    }
  }

  Color _getColor() {
    switch (careType) {
      case CareType.water:
        return const Color(0xFF42A5F5); // 青い水滴
      case CareType.fertilize:
        return const Color(0xFFFFD54F); // 黄色いキラキラ
      case CareType.sunlight:
        return const Color(0xFFFFCA28); // オレンジの星
      case CareType.repot:
        return const Color(0xFFF06292); // ピンクのハート
    }
  }

  @override
  bool shouldRepaint(covariant _ReactionPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
