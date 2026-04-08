import 'package:platza/domain/enums/enums.dart';

/// Enum ↔ String 変換ヘルパー

PlantLocation plantLocationFromString(String value) =>
    PlantLocation.values.firstWhere((e) => e.name == value);

String plantLocationToString(PlantLocation value) => value.name;

PlantStatus plantStatusFromString(String value) =>
    PlantStatus.values.firstWhere((e) => e.name == value);

String plantStatusToString(PlantStatus value) => value.name;

GrowthStage growthStageFromString(String value) =>
    GrowthStage.values.firstWhere((e) => e.name == value);

String growthStageToString(GrowthStage value) => value.name;

CareType careTypeFromString(String value) =>
    CareType.values.firstWhere((e) => e.name == value);

String careTypeToString(CareType value) => value.name;
