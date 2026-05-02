import 'dart:async';

/// Firestore SDK の write 系 Future がオフライン／不安定ネットワーク下で
/// サーバー ACK を待ち続けて解決しないケースのワークアラウンド用タイムアウト。
///
/// ローカルキャッシュへの書き込み自体は同期的に完了しているため、
/// このタイムアウトに到達した時点で「書いたものとして次へ進めて良い」
/// とみなしてよい。サーバーへの同期は SDK のバックグラウンド再試行に任せる。
const Duration kFirestoreSyncTimeout = Duration(seconds: 5);

/// Firestore write 用の薄いタイムアウトラッパー。
///
/// [write] が [timeout] 以内に解決しない場合は [TimeoutException] を黙殺して
/// 正常完了として戻る。Firestore 以外の例外はそのまま呼び出し元へ再スローする。
///
/// 主に `set()` / `update()` / `delete()` のように
/// 「ローカルキャッシュへの書き込みが成功した時点で UX 上は完了扱いにしたい」
/// 用途で利用する。
Future<void> writeWithSyncTimeout(
  Future<void> write, {
  Duration timeout = kFirestoreSyncTimeout,
}) async {
  try {
    await write.timeout(timeout);
  } on TimeoutException {
    // ローカルキャッシュ書き込みは完了しており、SDK がサーバー同期を継続する。
  }
}
