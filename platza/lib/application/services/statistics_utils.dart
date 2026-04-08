import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';

/// 統計画面用のユーティリティ関数群
///
/// すべて純粋関数として実装し、テスト容易性を確保。
class StatisticsUtils {
  StatisticsUtils._();

  /// 今週（月曜〜日曜）のお世話回数を計算する
  static int calculateWeeklyCareCount(List<CareLog> logs) {
    final now = DateTime.now();
    final monday = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
    final sundayEnd = monday.add(const Duration(days: 7));

    return logs.where((log) {
      return !log.performedAt.isBefore(monday) &&
          log.performedAt.isBefore(sundayEnd);
    }).length;
  }

  /// 今月のお世話回数を計算する
  static int calculateMonthlyCareCount(List<CareLog> logs) {
    final now = DateTime.now();
    final firstOfMonth = DateTime(now.year, now.month);
    final firstOfNextMonth = DateTime(now.year, now.month + 1);

    return logs.where((log) {
      return !log.performedAt.isBefore(firstOfMonth) &&
          log.performedAt.isBefore(firstOfNextMonth);
    }).length;
  }

  /// ケア種別ごとの回数を計算する
  static Map<CareType, int> calculateCareTypeBreakdown(List<CareLog> logs) {
    final breakdown = <CareType, int>{};
    for (final type in CareType.values) {
      breakdown[type] = 0;
    }
    for (final log in logs) {
      breakdown[log.careType] = (breakdown[log.careType] ?? 0) + 1;
    }
    return breakdown;
  }

  /// 直近N日間の日別お世話回数を計算する
  ///
  /// 返り値は長さ [days] のリストで、index 0 が最も古い日。
  static List<int> calculateDailyActivity(List<CareLog> logs, int days) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final counts = List<int>.filled(days, 0);

    for (final log in logs) {
      final logDate = DateTime(
        log.performedAt.year,
        log.performedAt.month,
        log.performedAt.day,
      );
      final diff = today.difference(logDate).inDays;
      if (diff >= 0 && diff < days) {
        // index 0 = oldest, index (days-1) = today
        counts[days - 1 - diff]++;
      }
    }

    return counts;
  }

  /// 全植物中の最大ストリーク日数を返す
  static int calculateBestStreak(List<Plant> plants) {
    if (plants.isEmpty) return 0;
    return plants
        .map((p) => p.streakDays)
        .reduce((a, b) => a > b ? a : b);
  }
}
