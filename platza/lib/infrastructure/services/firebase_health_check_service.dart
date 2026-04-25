import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore に対する書き込み・読み込みの疎通確認を行うサービス。
///
/// 「バックエンド構築」ストーリの受け入れ条件「Flutter アプリから通信する
/// 疎通確認ができている」を満たすための最小実装。
class FirebaseHealthCheckService {
  FirebaseHealthCheckService(this._firestore);

  final FirebaseFirestore _firestore;

  static const String _collectionPath = '_health';
  static const String _docId = 'ping';

  Future<bool> ping() async {
    final doc = _firestore.collection(_collectionPath).doc(_docId);
    await doc.set({'pingedAt': FieldValue.serverTimestamp()});
    final snapshot = await doc.get();
    return snapshot.exists;
  }
}
