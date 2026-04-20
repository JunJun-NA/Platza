import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';

/// お世話予定の残り日数を色分けされたバッジで表示
///
/// [daysLeft] の正負で状態が決まる:
/// - 負数: 超過（danger カラー）
/// - 0: 今日（warning カラー）
/// - 1〜2: もうすぐ（accent orange）
/// - 3 以上: 余裕あり（subtle）
class ScheduleStatusBadge extends StatelessWidget {
  const ScheduleStatusBadge({super.key, required this.daysLeft});

  final int daysLeft;

  String get _label {
    if (daysLeft < 0) return '${-daysLeft}日超過';
    if (daysLeft == 0) return '今日';
    if (daysLeft == 1) return '明日';
    return 'あと$daysLeft日';
  }

  ({Color fg, Color bg}) _colors() {
    if (daysLeft < 0) {
      return (fg: AppColors.textDanger, bg: AppColors.backgroundDangerLight);
    }
    if (daysLeft == 0) {
      return (fg: AppColors.textWarning, bg: AppColors.backgroundWarningLight);
    }
    if (daysLeft <= 2) {
      return (
        fg: AppColors.textAccentOrange,
        bg: AppColors.backgroundAccentOrange,
      );
    }
    return (fg: AppColors.textSubtle, bg: AppColors.surfaceTertiary);
  }

  @override
  Widget build(BuildContext context) {
    final c = _colors();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(color: c.bg, borderRadius: AppRadius.all8),
      child: Text(
        _label,
        style: AppTypography.label.copyWith(
          color: c.fg,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
