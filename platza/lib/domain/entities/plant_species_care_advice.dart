import 'package:platza/domain/entities/plant_species.dart';
import 'package:platza/domain/enums/enums.dart';

/// 季節ごとのお世話アドバイスを取り出すための拡張
extension PlantSpeciesCareAdvice on PlantSpecies {
  /// 指定した季節向けのケアアドバイス。
  /// 夏: [summerCare] / 冬: [winterCare] / 春・秋: `null`（汎用文扱い）
  String? careAdviceFor(Season season) {
    final advice = switch (season) {
      Season.summer => summerCare,
      Season.winter => winterCare,
      Season.spring || Season.autumn => null,
    };
    if (advice == null) return null;
    return advice.trim().isEmpty ? null : advice;
  }
}
