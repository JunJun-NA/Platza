import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 認証操作をまとめたサービス。
///
/// 設計方針:
/// - 起動時は必ず匿名サインインしてゲスト状態にする (`ensureSignedIn`)
/// - Apple / メールへのアップグレードは `linkWithCredential` を試み、
///   既に同じ資格情報のアカウントがある場合は `signInWithCredential` に
///   フォールバックして既存アカウントへ乗り換える
/// - サインアウト後は再び匿名サインインしてゲスト状態を維持する
class AuthService {
  AuthService(this._auth);

  final FirebaseAuth _auth;

  /// このインストールで一度でも `ensureSignedIn` を通過したかを示すフラグの保存キー。
  ///
  /// iOS の Keychain は **アプリをアンインストールしても保持される** 仕様のため、
  /// 何もしないと再インストール直後に前回のサインイン状態が復元されてしまう。
  /// このフラグを SharedPreferences（アンインストールで消える）に持つことで、
  /// 「Keychain にトークンがあるが、SharedPreferences にフラグがない」=
  /// 新規インストール直後と判定し、Keychain 残存セッションを破棄してから
  /// 匿名サインインしなおす。
  @visibleForTesting
  static const hasLaunchedBeforeKey = 'platza_auth_has_launched_before';

  /// `authStateChanges()` は uid が変わるとき（サインイン / サインアウト）にしか
  /// 発火しないため、`linkWithCredential` でプロバイダが追加されたときに UI が
  /// 更新されない。`userChanges()` を使うことで連携 / 解除 / プロフィール変更でも
  /// 再評価される。
  Stream<User?> authStateChanges() => _auth.userChanges();
  User? get currentUser => _auth.currentUser;

  /// 未ログインなら匿名サインインする。既にサインイン済みなら何もしない。
  ///
  /// 新規インストール直後（[hasLaunchedBeforeKey] が未設定）には iOS Keychain
  /// に残っている前回インストールのセッションを破棄してから匿名サインインする。
  Future<void> ensureSignedIn() async {
    await _resetSessionOnFreshInstall();
    if (_auth.currentUser != null) return;
    await _auth.signInAnonymously();
  }

  Future<void> _resetSessionOnFreshInstall() async {
    final prefs = await SharedPreferences.getInstance();
    final hasLaunchedBefore = prefs.getBool(hasLaunchedBeforeKey) ?? false;
    if (hasLaunchedBefore) return;

    if (_auth.currentUser != null) {
      await _auth.signOut();
    }
    await prefs.setBool(hasLaunchedBeforeKey, true);
  }

  /// Apple Sign In でアカウントを連携 / サインインする。
  /// 匿名状態なら既存 uid を保持してアップグレード、それ以外は通常サインイン。
  ///
  /// Firebase の `AppleAuthProvider` 経由で `signInWithProvider` /
  /// `linkWithProvider` を呼ぶ実装。Service ID + Web Auth ハンドラ URL を
  /// 用いるため audience ミスマッチが起きず、ネイティブ `OAuthCredential`
  /// 方式で発生していた `Invalid OAuth response from apple.com` を避けられる。
  Future<void> linkWithApple() async {
    final provider = AppleAuthProvider()
      ..addScope('email')
      ..addScope('name');

    final user = _auth.currentUser;
    if (user != null && user.isAnonymous) {
      try {
        await user.linkWithProvider(provider);
        return;
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          debugPrint(
            '[AuthService] linkWithProvider(apple) failed: code=${e.code} message=${e.message}',
          );
        }
        if (e.code == 'credential-already-in-use' ||
            e.code == 'email-already-in-use') {
          final fallback = e.credential;
          if (fallback != null) {
            await _auth.signInWithCredential(fallback);
          } else {
            await _auth.signInWithProvider(provider);
          }
          return;
        }
        if (e.code == 'user-not-found') {
          await _auth.signOut();
          await _auth.signInWithProvider(provider);
          return;
        }
        rethrow;
      }
    }
    await _auth.signInWithProvider(provider);
  }

  /// メール / パスワードでアカウントを連携 / サインインする。
  /// - 匿名状態 + メール未登録: linkWithCredential（既存 uid を保持）
  /// - 匿名状態 + メール登録済み: signInWithCredential にフォールバック（既存アカウントへ乗り換え）
  /// - 未ログイン or 連携済み: signIn / createUser を試みる
  Future<void> linkWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    final user = _auth.currentUser;

    if (user != null && user.isAnonymous) {
      try {
        await user.linkWithCredential(credential);
        return;
      } on FirebaseAuthException catch (e) {
        if (e.code != 'email-already-in-use' && e.code != 'credential-already-in-use') {
          rethrow;
        }
        // 既存アカウントがある場合は乗り換え（既存匿名アカウントは破棄される）
        await _auth.signInWithCredential(credential);
        return;
      }
    }

    // 未ログイン または 既に連携済みアカウント: 既存アカウントへサインイン
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return;
      }
      rethrow;
    }
  }

  /// サインアウトしてからゲスト（匿名）として再サインインする。
  Future<void> signOut() async {
    await _auth.signOut();
    await ensureSignedIn();
  }

}

/// FirebaseAuthException を UI 向けの日本語メッセージに変換する。
String authErrorMessage(Object error) {
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'invalid-email':
        return 'メールアドレスの形式が正しくありません';
      case 'weak-password':
        return 'パスワードは 6 文字以上で設定してください';
      case 'wrong-password':
        return 'メールアドレスまたはパスワードが違います';
      case 'invalid-credential':
        // Apple / メール / Google など複数フローで発生し得るため、原因は限定しない。
        return '認証情報が無効か、有効期限が切れています。もう一度お試しください';
      case 'user-not-found':
        return 'アカウントが見つかりません';
      case 'email-already-in-use':
        return 'このメールアドレスは既に別のアカウントで使われています';
      case 'too-many-requests':
        return '試行回数が多すぎます。しばらくしてからお試しください';
      case 'network-request-failed':
        return 'ネットワークに接続できません';
      default:
        return '認証エラー (${error.code})';
    }
  }
  return '予期しないエラーが発生しました';
}
