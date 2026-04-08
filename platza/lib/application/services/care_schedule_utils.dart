import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';

/// お世話間隔変更時に次回予定日を再計算する
///
/// 最後のお世話日 + 新しい間隔日数で算出。
/// お世話未実施の場合は植物の登録日 + 間隔日数を使用。
DateTime calculateNextDueDate({
  required CareType careType,
  required Plant plant,
  required int intervalDays,
}) {
  DateTime? lastCareDate;
  switch (careType) {
    case CareType.water:
      lastCareDate = plant.lastWatered;
    case CareType.fertilize:
      lastCareDate = plant.lastFertilized;
    case CareType.repot:
      lastCareDate = plant.lastRepotted;
    case CareType.sunlight:
      lastCareDate = null;
  }

  final baseDate = lastCareDate ?? plant.createdAt;
  return baseDate.add(Duration(days: intervalDays));
}
