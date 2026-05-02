import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platza/core/utils/firestore_sync_timeout.dart';
import 'package:platza/domain/entities/plant.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/domain/repositories/plant_repository.dart';

/// Cloud Firestore 実装の `PlantRepository`。
///
/// `users/{uid}/plants` subcollection に保存する。
/// スキーマは [`docs/firestore_schema.md`](../../../../docs/firestore_schema.md)
/// を参照。
class FirestorePlantRepository implements PlantRepository {
  FirestorePlantRepository({
    required FirebaseFirestore firestore,
    required String uid,
  })  : _firestore = firestore,
        _uid = uid;

  final FirebaseFirestore _firestore;
  final String _uid;

  CollectionReference<Map<String, dynamic>> get _plantsRef =>
      _firestore.collection('users').doc(_uid).collection('plants');

  @override
  Future<List<Plant>> getAllPlants() async {
    final snapshot = await _plantsRef.get();
    return snapshot.docs.map((doc) => _toDomain(doc.id, doc.data())).toList();
  }

  @override
  Future<Plant?> getPlantById(String id) async {
    final doc = await _plantsRef.doc(id).get();
    final data = doc.data();
    if (data == null) return null;
    return _toDomain(doc.id, data);
  }

  @override
  Future<void> addPlant(Plant plant) {
    return writeWithSyncTimeout(_plantsRef.doc(plant.id).set(_toMap(plant)));
  }

  @override
  Future<void> updatePlant(Plant plant) {
    return writeWithSyncTimeout(
      _plantsRef.doc(plant.id).set(_toMap(plant), SetOptions(merge: true)),
    );
  }

  @override
  Future<void> deletePlant(String id) {
    return writeWithSyncTimeout(_plantsRef.doc(id).delete());
  }

  @override
  Stream<List<Plant>> watchAllPlants() {
    return _plantsRef.snapshots().map(
          (snap) =>
              snap.docs.map((doc) => _toDomain(doc.id, doc.data())).toList(),
        );
  }

  Map<String, dynamic> _toMap(Plant plant) {
    return {
      'id': plant.id,
      'nickname': plant.nickname,
      'speciesId': plant.speciesId,
      'location': plant.location.name,
      'status': plant.status.name,
      'growthStage': plant.growthStage.name,
      'lastWatered': plant.lastWatered != null
          ? Timestamp.fromDate(plant.lastWatered!)
          : null,
      'lastFertilized': plant.lastFertilized != null
          ? Timestamp.fromDate(plant.lastFertilized!)
          : null,
      'lastRepotted': plant.lastRepotted != null
          ? Timestamp.fromDate(plant.lastRepotted!)
          : null,
      'createdAt': Timestamp.fromDate(plant.createdAt),
      'streakDays': plant.streakDays,
    };
  }

  Plant _toDomain(String docId, Map<String, dynamic> data) {
    return Plant(
      id: (data['id'] as String?) ?? docId,
      nickname: data['nickname'] as String,
      speciesId: data['speciesId'] as String,
      location: PlantLocation.values.byName(data['location'] as String),
      status: PlantStatus.values.byName(data['status'] as String),
      growthStage: GrowthStage.values.byName(data['growthStage'] as String),
      lastWatered: _toDateTime(data['lastWatered']),
      lastFertilized: _toDateTime(data['lastFertilized']),
      lastRepotted: _toDateTime(data['lastRepotted']),
      createdAt: _toDateTime(data['createdAt']) ?? DateTime.now(),
      streakDays: (data['streakDays'] as num?)?.toInt() ?? 0,
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
