import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/plant.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/home/data/room_layout.dart';

Plant _plant(String id) => Plant(
      id: id,
      nickname: 'p-$id',
      speciesId: 'echeveria',
      location: PlantLocation.indoor,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  group('assignPlantsToSlots', () {
    final slots = List<PlantSlot>.generate(
      3,
      (i) => PlantSlot(id: 's$i', x: 0.5, y: 0.5, maxSize: 100),
    );

    test('植物が空のときは空のリストを返す', () {
      final result = assignPlantsToSlots([], slots);
      expect(result, isEmpty);
    });

    test('植物 < スロットのときは植物全件を順に割り当てる', () {
      final plants = [_plant('a'), _plant('b')];
      final result = assignPlantsToSlots(plants, slots);
      expect(result.length, 2);
      expect(result[0].plant.id, 'a');
      expect(result[0].slot.id, 's0');
      expect(result[1].plant.id, 'b');
      expect(result[1].slot.id, 's1');
    });

    test('植物 > スロットのとき超過分は捨てられる', () {
      final plants =
          List.generate(5, (i) => _plant(i.toString()));
      final result = assignPlantsToSlots(plants, slots);
      expect(result.length, 3);
      expect(result.last.slot.id, 's2');
    });
  });

  group('kRoomSlots', () {
    test('スロット定義は重複なし、座標は 0..1 範囲内', () {
      final ids = kRoomSlots.map((s) => s.id).toSet();
      expect(ids.length, kRoomSlots.length, reason: 'IDが重複している');
      for (final s in kRoomSlots) {
        expect(s.x, inInclusiveRange(0.0, 1.0));
        expect(s.y, inInclusiveRange(0.0, 1.0));
        expect(s.maxSize, greaterThan(0));
      }
    });
  });
}
