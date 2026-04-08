import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/care_log.dart';
import 'package:platza/domain/enums/enums.dart';

void main() {
  group('CareLog Entity', () {
    test('creates with required fields', () {
      final performedAt = DateTime(2024, 6, 15, 10, 30);
      final log = CareLog(
        id: 'log-1',
        plantId: 'plant-1',
        careType: CareType.water,
        performedAt: performedAt,
      );

      expect(log.id, 'log-1');
      expect(log.plantId, 'plant-1');
      expect(log.careType, CareType.water);
      expect(log.performedAt, performedAt);
      expect(log.note, isNull);
    });

    test('creates with optional note', () {
      final log = CareLog(
        id: 'log-2',
        plantId: 'plant-1',
        careType: CareType.fertilize,
        performedAt: DateTime(2024, 6, 15),
        note: '液体肥料を使用',
      );

      expect(log.note, '液体肥料を使用');
    });

    test('supports all CareType values', () {
      final expectedTypes = [
        CareType.water,
        CareType.fertilize,
        CareType.repot,
        CareType.sunlight,
      ];

      expect(CareType.values, expectedTypes);
      expect(CareType.values.length, 4);
    });

    test('CareType has correct labels', () {
      expect(CareType.water.label, '水やり');
      expect(CareType.fertilize.label, '肥料');
      expect(CareType.repot.label, '植え替え');
      expect(CareType.sunlight.label, '日当たり変更');
    });

    test('CareType has correct emojis', () {
      expect(CareType.water.emoji, isNotEmpty);
      expect(CareType.fertilize.emoji, isNotEmpty);
      expect(CareType.repot.emoji, isNotEmpty);
      expect(CareType.sunlight.emoji, isNotEmpty);
    });
  });
}
