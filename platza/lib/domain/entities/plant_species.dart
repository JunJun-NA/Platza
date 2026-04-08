import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:platza/domain/enums/enums.dart';

part 'plant_species.freezed.dart';
part 'plant_species.g.dart';

/// 植物の種類マスターデータ
@freezed
abstract class PlantSpecies with _$PlantSpecies {
  const factory PlantSpecies({
    required String id,
    required String name,
    required PlantCategory category,
    required int waterFrequencyDays,
    required int fertilizerFrequencyDays,
    required SunlightNeed sunlightNeed,
    required String winterCare,
    required String summerCare,
    required String description,
    required String assetPrefix,
  }) = _PlantSpecies;

  factory PlantSpecies.fromJson(Map<String, dynamic> json) =>
      _$PlantSpeciesFromJson(json);
}
