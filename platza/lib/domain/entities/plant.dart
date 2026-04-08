import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:platza/domain/enums/enums.dart';

part 'plant.freezed.dart';
part 'plant.g.dart';

/// ユーザーが登録した植物
@freezed
abstract class Plant with _$Plant {
  const factory Plant({
    required String id,
    required String nickname,
    required String speciesId,
    required PlantLocation location,
    @Default(PlantStatus.happy) PlantStatus status,
    @Default(GrowthStage.seedling) GrowthStage growthStage,
    DateTime? lastWatered,
    DateTime? lastFertilized,
    DateTime? lastRepotted,
    required DateTime createdAt,
    @Default(0) int streakDays,
  }) = _Plant;

  const Plant._();

  factory Plant.fromJson(Map<String, dynamic> json) => _$PlantFromJson(json);

  /// 水やりが必要かどうかを判定（外部からfrequencyを渡す）
  bool needsWatering(int frequencyDays) {
    if (lastWatered == null) return true;
    final daysSinceWatered =
        DateTime.now().difference(lastWatered!).inDays;
    return daysSinceWatered >= frequencyDays;
  }

  /// 肥料が必要かどうかを判定
  bool needsFertilizing(int frequencyDays) {
    if (lastFertilized == null) return true;
    final daysSinceFertilized =
        DateTime.now().difference(lastFertilized!).inDays;
    return daysSinceFertilized >= frequencyDays;
  }
}
