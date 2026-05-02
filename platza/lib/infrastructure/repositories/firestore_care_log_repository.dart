import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platza/core/utils/firestore_sync_timeout.dart';
import 'package:platza/domain/entities/care_log.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/domain/repositories/care_log_repository.dart';

/// Cloud Firestore 実装の `CareLogRepository`。
///
/// `users/{uid}/care_logs` subcollection に保存する。
/// スキーマは [`docs/firestore_schema.md`](../../../../docs/firestore_schema.md)
/// を参照。
class FirestoreCareLogRepository implements CareLogRepository {
  FirestoreCareLogRepository({
    required FirebaseFirestore firestore,
    required String uid,
  })  : _firestore = firestore,
        _uid = uid;

  final FirebaseFirestore _firestore;
  final String _uid;

  CollectionReference<Map<String, dynamic>> get _logsRef =>
      _firestore.collection('users').doc(_uid).collection('care_logs');

  @override
  Future<List<CareLog>> getLogsForPlant(String plantId) async {
    final snapshot = await _logsRef
        .where('plantId', isEqualTo: plantId)
        .orderBy('performedAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => _toDomain(doc.id, doc.data())).toList();
  }

  @override
  Future<List<CareLog>> getLogsByDateRange(
      DateTime start, DateTime end) async {
    final snapshot = await _logsRef
        .where('performedAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('performedAt', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .orderBy('performedAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => _toDomain(doc.id, doc.data())).toList();
  }

  @override
  Future<List<CareLog>> getLogsByType(
      String plantId, CareType careType) async {
    final snapshot = await _logsRef
        .where('plantId', isEqualTo: plantId)
        .where('careType', isEqualTo: careType.name)
        .orderBy('performedAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => _toDomain(doc.id, doc.data())).toList();
  }

  @override
  Future<void> addLog(CareLog log) {
    return writeWithSyncTimeout(_logsRef.doc(log.id).set(_toMap(log)));
  }

  @override
  Future<void> updateLog(CareLog log) {
    return writeWithSyncTimeout(_logsRef.doc(log.id).set(_toMap(log)));
  }

  @override
  Future<void> deleteLog(String id) {
    return writeWithSyncTimeout(_logsRef.doc(id).delete());
  }

  @override
  Stream<List<CareLog>> watchLogsForPlant(String plantId) {
    return _logsRef
        .where('plantId', isEqualTo: plantId)
        .orderBy('performedAt', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => _toDomain(doc.id, doc.data())).toList());
  }

  Map<String, dynamic> _toMap(CareLog log) {
    return {
      'id': log.id,
      'plantId': log.plantId,
      'careType': log.careType.name,
      'performedAt': Timestamp.fromDate(log.performedAt),
      'note': log.note,
    };
  }

  CareLog _toDomain(String docId, Map<String, dynamic> data) {
    return CareLog(
      id: (data['id'] as String?) ?? docId,
      plantId: data['plantId'] as String,
      careType: CareType.values.byName(data['careType'] as String),
      performedAt: _toDateTime(data['performedAt']) ?? DateTime.now(),
      note: data['note'] as String?,
    );
  }

  DateTime? _toDateTime(Object? value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
