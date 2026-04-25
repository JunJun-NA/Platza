import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/infrastructure/services/firebase_health_check_service.dart';

void main() {
  group('FirebaseHealthCheckService', () {
    late FakeFirebaseFirestore firestore;
    late FirebaseHealthCheckService service;

    setUp(() {
      firestore = FakeFirebaseFirestore();
      service = FirebaseHealthCheckService(firestore);
    });

    test('ping は書き込み後に true を返す', () async {
      final result = await service.ping();

      expect(result, isTrue);
    });

    test('ping 後に _health/ping ドキュメントが存在し pingedAt が記録される', () async {
      await service.ping();

      final snapshot = await firestore.collection('_health').doc('ping').get();
      expect(snapshot.exists, isTrue);
      expect(snapshot.data(), containsPair('pingedAt', isA<Timestamp>()));
    });
  });
}
