import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/infrastructure/services/auth_service.dart';

// 注: firebase_auth_mocks は MockUser の isAnonymous を変更できないため、
// 匿名 → リンクや signOut → 再匿名サインインの遷移はモックでは検証できない。
// その部分は実機 / emulator での手動検証に委ねる。
// このファイルでは確実にテスト可能な範囲（ensureSignedIn の分岐とエラー文言）に絞る。

void main() {
  group('AuthService.ensureSignedIn', () {
    test('未サインイン状態なら匿名サインインする', () async {
      final auth = MockFirebaseAuth();
      final service = AuthService(auth);

      expect(auth.currentUser, isNull);
      await service.ensureSignedIn();

      expect(auth.currentUser, isNotNull);
      expect(auth.currentUser!.isAnonymous, isTrue);
    });

    test('既にサインイン済みなら何もしない', () async {
      final user = MockUser(uid: 'existing-uid', isAnonymous: false);
      final auth = MockFirebaseAuth(signedIn: true, mockUser: user);
      final service = AuthService(auth);

      await service.ensureSignedIn();

      expect(auth.currentUser?.uid, 'existing-uid');
      expect(auth.currentUser?.isAnonymous, isFalse);
    });
  });

  group('authErrorMessage', () {
    test('FirebaseAuthException のコードに応じた日本語メッセージを返す', () {
      expect(
        authErrorMessage(FirebaseAuthException(code: 'invalid-email')),
        contains('メールアドレス'),
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'weak-password')),
        contains('6 文字'),
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'wrong-password')),
        contains('違います'),
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'email-already-in-use')),
        contains('既に別のアカウント'),
      );
      expect(
        authErrorMessage(FirebaseAuthException(code: 'network-request-failed')),
        contains('ネットワーク'),
      );
    });

    test('未知のコードはコード番号付きの汎用メッセージを返す', () {
      expect(
        authErrorMessage(FirebaseAuthException(code: 'unknown-xyz')),
        contains('unknown-xyz'),
      );
    });

    test('FirebaseAuthException 以外は汎用メッセージを返す', () {
      expect(authErrorMessage(StateError('boom')), contains('予期しない'));
    });
  });
}
