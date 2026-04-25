import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:platza/domain/entities/app_user.dart';
import 'package:platza/infrastructure/services/auth_service.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) =>
    AuthService(ref.watch(firebaseAuthProvider));

/// Firebase の認証状態変化を購読する。
@Riverpod(keepAlive: true)
Stream<User?> firebaseAuthStateChanges(Ref ref) =>
    ref.watch(authServiceProvider).authStateChanges();

/// 現在の AppUser。未サインイン (起動直後の極短時間) は null。
@riverpod
AppUser? currentAppUser(Ref ref) {
  final user = ref.watch(firebaseAuthStateChangesProvider).value;
  if (user == null) return null;
  return AppUser(
    uid: user.uid,
    isAnonymous: user.isAnonymous,
    email: user.email,
    displayName: user.displayName,
  );
}
