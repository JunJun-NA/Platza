import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/infrastructure/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 注: firebase_auth_mocks は MockUser の isAnonymous を変更できないため、
// 匿名 → リンクや signOut → 再匿名サインインの遷移はモックでは検証できない。
// その部分は実機 / emulator での手動検証に委ねる。
// このファイルでは確実にテスト可能な範囲（ensureSignedIn の分岐とエラー文言）に絞る。

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthService.ensureSignedIn', () {
    test('未サインインかつ初回起動なら匿名サインインしてフラグを立てる', () async {
      SharedPreferences.setMockInitialValues({});
      final auth = MockFirebaseAuth();
      final service = AuthService(auth);

      expect(auth.currentUser, isNull);
      await service.ensureSignedIn();

      expect(auth.currentUser, isNotNull);
      expect(auth.currentUser!.isAnonymous, isTrue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AuthService.hasLaunchedBeforeKey), isTrue);
    });

    test('2 回目以降の起動で既にサインイン済みなら何もしない', () async {
      SharedPreferences.setMockInitialValues({
        AuthService.hasLaunchedBeforeKey: true,
      });
      final user = MockUser(uid: 'existing-uid', isAnonymous: false);
      final auth = MockFirebaseAuth(signedIn: true, mockUser: user);
      final service = AuthService(auth);

      await service.ensureSignedIn();

      expect(auth.currentUser?.uid, 'existing-uid');
      expect(auth.currentUser?.isAnonymous, isFalse);
    });

    test(
        '新規インストール直後 (フラグ未設定 + 既存セッションあり) でも処理が完走しフラグが立つ',
        () async {
      // フラグ未設定 = SharedPreferences には値がない（新規インストール直後）。
      SharedPreferences.setMockInitialValues({});
      // firebase_auth_mocks の制約上、mockUser の isAnonymous は途中で変えられない
      // ため、Keychain 残存セッションを匿名として模擬する（実機では非匿名のケースが
      // 本来の対象だが、その遷移はモックで表現できないので emulator / 実機検証へ委ねる）。
      final stale = MockUser(uid: 'stale-uid', isAnonymous: true);
      final auth = MockFirebaseAuth(signedIn: true, mockUser: stale);
      final service = AuthService(auth);

      // signOut → signInAnonymously がエラーなく完走することの検証。
      await service.ensureSignedIn();
      expect(auth.currentUser, isNotNull);
      expect(auth.currentUser!.isAnonymous, isTrue);

      // フラグが立つので 2 回目以降の起動では signOut は走らない。
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AuthService.hasLaunchedBeforeKey), isTrue);
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
