import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

  Stream<User?> authStateChanges() => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  /// 未ログインなら匿名サインインする。既にサインイン済みなら何もしない。
  Future<void> ensureSignedIn() async {
    if (_auth.currentUser != null) return;
    await _auth.signInAnonymously();
  }

  /// Apple Sign In でアカウントを連携 / サインインする。
  /// 匿名状態なら既存 uid を保持してアップグレード、それ以外は通常サインイン。
  Future<void> linkWithApple() async {
    final rawNonce = _generateNonce();
    final hashedNonce = _sha256(rawNonce);

    final apple = await SignInWithApple.getAppleIDCredential(
      scopes: const [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final credential = OAuthProvider('apple.com').credential(
      idToken: apple.identityToken,
      rawNonce: rawNonce,
    );

    await _signInOrLink(credential);
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

  Future<void> _signInOrLink(AuthCredential credential) async {
    final user = _auth.currentUser;
    if (user != null && user.isAnonymous) {
      try {
        await user.linkWithCredential(credential);
        return;
      } on FirebaseAuthException catch (e) {
        if (e.code != 'credential-already-in-use' &&
            e.code != 'email-already-in-use') {
          rethrow;
        }
        // 既存アカウントへ乗り換え
        await _auth.signInWithCredential(credential);
        return;
      }
    }
    await _auth.signInWithCredential(credential);
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
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
      case 'invalid-credential':
        return 'メールアドレスまたはパスワードが違います';
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
