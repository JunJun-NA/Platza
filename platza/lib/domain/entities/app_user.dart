import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

/// アプリ内で扱う認証ユーザー。Firebase の `User` から必要なフィールドだけを抽出する。
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required bool isAnonymous,
    String? email,
    String? displayName,
  }) = _AppUser;
}
