import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/plant.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/infrastructure/repositories/firestore_plant_repository.dart';

const _uid = 'test-user';

Plant buildPlant({
  String id = 'plant-1',
  String nickname = 'ぷにぷに',
  String speciesId = 'echeveria_elegans',
  PlantLocation location = PlantLocation.window,
  PlantStatus status = PlantStatus.happy,
  GrowthStage growthStage = GrowthStage.mature,
  DateTime? lastWatered,
  DateTime? lastFertilized,
  DateTime? lastRepotted,
  DateTime? createdAt,
  int streakDays = 0,
}) {
  return Plant(
    id: id,
    nickname: nickname,
    speciesId: speciesId,
    location: location,
    status: status,
    growthStage: growthStage,
    lastWatered: lastWatered,
    lastFertilized: lastFertilized,
    lastRepotted: lastRepotted,
    createdAt: createdAt ?? DateTime(2026, 1, 1),
    streakDays: streakDays,
  );
}

void main() {
  late FakeFirebaseFirestore firestore;
  late FirestorePlantRepository repo;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    repo = FirestorePlantRepository(firestore: firestore, uid: _uid);
  });

  group('FirestorePlantRepository', () {
    test('addPlant で users/{uid}/plants/{plantId} に保存される', () async {
      final plant = buildPlant();
      await repo.addPlant(plant);

      final snap = await firestore
          .collection('users')
          .doc(_uid)
          .collection('plants')
          .doc(plant.id)
          .get();

      expect(snap.exists, isTrue);
      final data = snap.data()!;
      expect(data['id'], plant.id);
      expect(data['nickname'], plant.nickname);
      expect(data['location'], 'window');
      expect(data['status'], 'happy');
      expect(data['growthStage'], 'mature');
      expect(data['createdAt'], isA<Timestamp>());
      expect((data['createdAt'] as Timestamp).toDate(), plant.createdAt);
    });

    test('getAllPlants で自分の植物だけが返る', () async {
      await repo.addPlant(buildPlant(id: 'p1', nickname: 'A'));
      await repo.addPlant(buildPlant(id: 'p2', nickname: 'B'));
      // 別ユーザーの植物は除外される
      await firestore
          .collection('users')
          .doc('other-user')
          .collection('plants')
          .doc('px')
          .set({'id': 'px', 'nickname': 'X'});

      final plants = await repo.getAllPlants();

      expect(plants.map((p) => p.id), containsAll(['p1', 'p2']));
      expect(plants.length, 2);
    });

    test('getPlantById で該当植物のみ取得できる', () async {
      await repo.addPlant(buildPlant(id: 'p1', nickname: 'A'));
      await repo.addPlant(buildPlant(id: 'p2', nickname: 'B'));

      final p1 = await repo.getPlantById('p1');
      final missing = await repo.getPlantById('missing');

      expect(p1, isNotNull);
      expect(p1!.nickname, 'A');
      expect(missing, isNull);
    });

    test('updatePlant でフィールドが書き換わる', () async {
      final plant = buildPlant(nickname: 'before');
      await repo.addPlant(plant);

      final updated = plant.copyWith(
        nickname: 'after',
        status: PlantStatus.thirsty,
        lastWatered: DateTime(2026, 4, 27, 10),
      );
      await repo.updatePlant(updated);

      final fetched = await repo.getPlantById(plant.id);
      expect(fetched!.nickname, 'after');
      expect(fetched.status, PlantStatus.thirsty);
      expect(fetched.lastWatered, DateTime(2026, 4, 27, 10));
    });

    test('deletePlant でドキュメントが消える', () async {
      final plant = buildPlant();
      await repo.addPlant(plant);
      expect(await repo.getPlantById(plant.id), isNotNull);

      await repo.deletePlant(plant.id);
      expect(await repo.getPlantById(plant.id), isNull);
    });

    test('watchAllPlants が変更を流す', () async {
      final stream = repo.watchAllPlants();
      final emissions = <List<Plant>>[];
      final sub = stream.listen(emissions.add);

      await repo.addPlant(buildPlant(id: 'p1', nickname: 'A'));
      await repo.addPlant(buildPlant(id: 'p2', nickname: 'B'));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(emissions, isNotEmpty);
      expect(emissions.last.length, 2);
      expect(emissions.last.map((p) => p.id), containsAll(['p1', 'p2']));

      await sub.cancel();
    });

    test('enum / Timestamp のラウンドトリップが安定している', () async {
      final plant = buildPlant(
        location: PlantLocation.outdoor,
        status: PlantStatus.blooming,
        growthStage: GrowthStage.flowering,
        lastWatered: DateTime(2026, 4, 1),
        lastFertilized: DateTime(2026, 3, 15),
        lastRepotted: DateTime(2025, 10, 1),
        streakDays: 12,
      );
      await repo.addPlant(plant);

      final fetched = await repo.getPlantById(plant.id);
      expect(fetched, isNotNull);
      expect(fetched!.location, PlantLocation.outdoor);
      expect(fetched.status, PlantStatus.blooming);
      expect(fetched.growthStage, GrowthStage.flowering);
      expect(fetched.lastWatered, plant.lastWatered);
      expect(fetched.lastFertilized, plant.lastFertilized);
      expect(fetched.lastRepotted, plant.lastRepotted);
      expect(fetched.streakDays, 12);
    });
  });
}
