import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/care_log.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/infrastructure/repositories/firestore_care_log_repository.dart';

const _uid = 'test-user';

CareLog buildLog({
  String id = 'log-1',
  String plantId = 'plant-1',
  CareType careType = CareType.water,
  DateTime? performedAt,
  String? note,
}) {
  return CareLog(
    id: id,
    plantId: plantId,
    careType: careType,
    performedAt: performedAt ?? DateTime(2026, 4, 1, 9),
    note: note,
  );
}

void main() {
  late FakeFirebaseFirestore firestore;
  late FirestoreCareLogRepository repo;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    repo = FirestoreCareLogRepository(firestore: firestore, uid: _uid);
  });

  group('FirestoreCareLogRepository', () {
    test('addLog で users/{uid}/care_logs/{logId} に保存される', () async {
      final log = buildLog(note: 'メモ');
      await repo.addLog(log);

      final snap = await firestore
          .collection('users')
          .doc(_uid)
          .collection('care_logs')
          .doc(log.id)
          .get();

      expect(snap.exists, isTrue);
      final data = snap.data()!;
      expect(data['id'], log.id);
      expect(data['plantId'], log.plantId);
      expect(data['careType'], 'water');
      expect(data['note'], 'メモ');
      expect(data['performedAt'], isA<Timestamp>());
      expect((data['performedAt'] as Timestamp).toDate(), log.performedAt);
    });

    test('getLogsForPlant で対象植物のログが新しい順に返る', () async {
      await repo.addLog(buildLog(
        id: 'old',
        performedAt: DateTime(2026, 3, 1),
      ));
      await repo.addLog(buildLog(
        id: 'new',
        performedAt: DateTime(2026, 4, 1),
      ));
      await repo.addLog(buildLog(
        id: 'mid',
        performedAt: DateTime(2026, 3, 15),
      ));
      // 別の植物のログは除外される
      await repo.addLog(buildLog(
        id: 'other',
        plantId: 'plant-2',
        performedAt: DateTime(2026, 4, 10),
      ));

      final logs = await repo.getLogsForPlant('plant-1');
      expect(logs.map((l) => l.id), ['new', 'mid', 'old']);
    });

    test('getLogsByDateRange で期間内のログが返る', () async {
      await repo.addLog(buildLog(
        id: 'before',
        performedAt: DateTime(2026, 3, 1),
      ));
      await repo.addLog(buildLog(
        id: 'in-range',
        performedAt: DateTime(2026, 4, 10),
      ));
      await repo.addLog(buildLog(
        id: 'after',
        performedAt: DateTime(2026, 5, 1),
      ));

      final logs = await repo.getLogsByDateRange(
        DateTime(2026, 4, 1),
        DateTime(2026, 4, 30),
      );

      expect(logs.length, 1);
      expect(logs.first.id, 'in-range');
    });

    test('getLogsByDateRange は境界日を含む', () async {
      final start = DateTime(2026, 4, 1);
      final end = DateTime(2026, 4, 30);

      await repo.addLog(buildLog(id: 'start', performedAt: start));
      await repo.addLog(buildLog(
        id: 'end',
        careType: CareType.fertilize,
        performedAt: end,
      ));

      final logs = await repo.getLogsByDateRange(start, end);
      expect(logs.length, 2);
    });

    test('getLogsByType で植物 + ケアタイプで絞り込まれる', () async {
      await repo.addLog(buildLog(
        id: 'water-1',
        careType: CareType.water,
        performedAt: DateTime(2026, 4, 1),
      ));
      await repo.addLog(buildLog(
        id: 'water-2',
        careType: CareType.water,
        performedAt: DateTime(2026, 4, 10),
      ));
      await repo.addLog(buildLog(
        id: 'fertilize-1',
        careType: CareType.fertilize,
        performedAt: DateTime(2026, 4, 5),
      ));

      final waterLogs = await repo.getLogsByType('plant-1', CareType.water);
      expect(waterLogs.length, 2);
      expect(waterLogs.every((l) => l.careType == CareType.water), isTrue);
      // performedAt 降順
      expect(waterLogs.first.id, 'water-2');

      final fertilizeLogs =
          await repo.getLogsByType('plant-1', CareType.fertilize);
      expect(fertilizeLogs.length, 1);
      expect(fertilizeLogs.first.id, 'fertilize-1');
    });

    test('updateLog で note や performedAt が書き換わる', () async {
      final log = buildLog(note: '元のメモ');
      await repo.addLog(log);

      final updated = log.copyWith(
        performedAt: DateTime(2026, 4, 5, 10),
        note: '修正後',
      );
      await repo.updateLog(updated);

      final logs = await repo.getLogsForPlant('plant-1');
      expect(logs.length, 1);
      expect(logs.first.performedAt, DateTime(2026, 4, 5, 10));
      expect(logs.first.note, '修正後');
    });

    test('updateLog で note を null に戻せる', () async {
      final log = buildLog(note: '消す予定');
      await repo.addLog(log);

      await repo.updateLog(log.copyWith(note: null));

      final logs = await repo.getLogsForPlant('plant-1');
      expect(logs.first.note, isNull);
    });

    test('deleteLog でドキュメントが消える', () async {
      await repo.addLog(buildLog(id: 'keep'));
      await repo.addLog(buildLog(id: 'delete'));

      await repo.deleteLog('delete');

      final logs = await repo.getLogsForPlant('plant-1');
      expect(logs.length, 1);
      expect(logs.first.id, 'keep');
    });

    test('watchLogsForPlant が変更を流す', () async {
      final stream = repo.watchLogsForPlant('plant-1');
      final emissions = <List<CareLog>>[];
      final sub = stream.listen(emissions.add);

      await repo.addLog(buildLog(id: 'l1', performedAt: DateTime(2026, 4, 1)));
      await repo.addLog(buildLog(id: 'l2', performedAt: DateTime(2026, 4, 2)));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(emissions, isNotEmpty);
      expect(emissions.last.length, 2);
      expect(emissions.last.first.id, 'l2');

      await sub.cancel();
    });

    test('別ユーザーの care_logs は読まれない', () async {
      await repo.addLog(buildLog(id: 'mine'));
      await firestore
          .collection('users')
          .doc('other-user')
          .collection('care_logs')
          .doc('not-mine')
          .set({
        'id': 'not-mine',
        'plantId': 'plant-1',
        'careType': 'water',
        'performedAt': Timestamp.fromDate(DateTime(2026, 4, 1)),
      });

      final logs = await repo.getLogsForPlant('plant-1');
      expect(logs.length, 1);
      expect(logs.first.id, 'mine');
    });

    test('enum / Timestamp のラウンドトリップが安定している', () async {
      final log = buildLog(
        careType: CareType.repot,
        performedAt: DateTime(2026, 4, 27, 14, 30, 15),
        note: '大きめの鉢に植え替え',
      );
      await repo.addLog(log);

      final logs = await repo.getLogsForPlant('plant-1');
      expect(logs.first.careType, CareType.repot);
      expect(logs.first.performedAt, log.performedAt);
      expect(logs.first.note, '大きめの鉢に植え替え');
    });
  });
}
