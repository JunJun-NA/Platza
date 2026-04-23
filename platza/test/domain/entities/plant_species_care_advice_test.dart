import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/plant_species.dart';
import 'package:platza/domain/entities/plant_species_care_advice.dart';
import 'package:platza/domain/enums/enums.dart';

PlantSpecies _species({
  String summerCare = '夏は風通しを確保',
  String winterCare = '冬は水控えめ',
}) {
  return PlantSpecies(
    id: 'test',
    name: 'テスト',
    category: PlantCategory.succulent,
    waterFrequencyDays: 7,
    fertilizerFrequencyDays: 30,
    repotFrequencyDays: 365,
    sunlightNeed: SunlightNeed.high,
    winterCare: winterCare,
    summerCare: summerCare,
    description: '',
    assetPrefix: 'test',
  );
}

void main() {
  group('PlantSpecies.careAdviceFor', () {
    test('夏は summerCare を返す', () {
      final species = _species(summerCare: '風通しの良い半日陰で管理');
      expect(species.careAdviceFor(Season.summer), '風通しの良い半日陰で管理');
    });

    test('冬は winterCare を返す', () {
      final species = _species(winterCare: '水やりを控えめに');
      expect(species.careAdviceFor(Season.winter), '水やりを控えめに');
    });

    test('春・秋は null を返す（汎用文扱い）', () {
      final species = _species();
      expect(species.careAdviceFor(Season.spring), isNull);
      expect(species.careAdviceFor(Season.autumn), isNull);
    });

    test('summerCare が空文字なら null', () {
      final species = _species(summerCare: '   ');
      expect(species.careAdviceFor(Season.summer), isNull);
    });

    test('winterCare が空文字なら null', () {
      final species = _species(winterCare: '');
      expect(species.careAdviceFor(Season.winter), isNull);
    });
  });
}
