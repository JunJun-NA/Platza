import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:platza/infrastructure/services/firebase_health_check_service.dart';

part 'firebase_providers.g.dart';

@Riverpod(keepAlive: true)
FirebaseFirestore firestore(Ref ref) => FirebaseFirestore.instance;

@Riverpod(keepAlive: true)
FirebaseHealthCheckService firebaseHealthCheckService(Ref ref) =>
    FirebaseHealthCheckService(ref.watch(firestoreProvider));
