import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:platza/application/providers/auth_providers.dart';
import 'package:platza/domain/entities/app_user.dart';
import 'package:platza/infrastructure/services/auth_service.dart';
import 'package:platza/presentation/account/email_link_dialog.dart';

/// 設定画面のアカウント連携セクション。
///
/// - 匿名状態: Apple / メールで連携できるボタンを表示
/// - 連携済み: メールアドレスとサインアウトボタンを表示
class AccountLinkSection extends ConsumerWidget {
  const AccountLinkSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentAppUserProvider);
    if (user == null) {
      return const ListTile(
        title: Text('読み込み中…'),
        leading: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    if (user.isAnonymous) {
      return _AnonymousActions(onError: (msg) => _showSnack(context, msg));
    }
    return _LinkedAccountInfo(
      user: user,
      onError: (msg) => _showSnack(context, msg),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

class _AnonymousActions extends ConsumerStatefulWidget {
  const _AnonymousActions({required this.onError});

  final void Function(String message) onError;

  @override
  ConsumerState<_AnonymousActions> createState() => _AnonymousActionsState();
}

class _AnonymousActionsState extends ConsumerState<_AnonymousActions> {
  bool _appleInProgress = false;

  Future<void> _signInWithApple() async {
    if (_appleInProgress) return;
    setState(() => _appleInProgress = true);
    try {
      await ref.read(authServiceProvider).linkWithApple();
    } on FirebaseAuthException catch (e) {
      // signInWithProvider 経由のキャンセルは web-context-cancelled で返る。
      if (e.code != 'web-context-cancelled' && e.code != 'canceled') {
        widget.onError(authErrorMessage(e));
      }
    } catch (e) {
      widget.onError(authErrorMessage(e));
    } finally {
      if (mounted) setState(() => _appleInProgress = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.person_outline),
          title: Text('ゲストとして利用中'),
          subtitle: Text(
            'アカウントを連携すると、別の端末でも同じデータを使えます',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SignInWithAppleButton(
            onPressed: _appleInProgress ? () {} : _signInWithApple,
            text: _appleInProgress ? '処理中...' : 'Apple で連携',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.mail_outline),
              label: const Text('メールで連携'),
              onPressed: () => EmailLinkDialog.show(context),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _LinkedAccountInfo extends ConsumerStatefulWidget {
  const _LinkedAccountInfo({required this.user, required this.onError});

  final AppUser user;
  final void Function(String message) onError;

  @override
  ConsumerState<_LinkedAccountInfo> createState() => _LinkedAccountInfoState();
}

class _LinkedAccountInfoState extends ConsumerState<_LinkedAccountInfo> {
  bool _signingOut = false;

  Future<void> _signOut() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('サインアウト'),
        content: const Text(
          'サインアウトすると、再びゲストとしてアプリを使うことになります。'
          '同じアカウントでサインインし直すことで、データには再びアクセスできます。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('サインアウト'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    if (_signingOut) return;
    setState(() => _signingOut = true);
    try {
      await ref.read(authServiceProvider).signOut();
    } catch (e) {
      widget.onError(authErrorMessage(e));
    } finally {
      if (mounted) setState(() => _signingOut = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.user.email;
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.account_circle_outlined),
          title: Text(email ?? 'アカウント連携済み'),
          subtitle:
              email == null ? const Text('Apple ID で連携') : const Text('メール連携'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.logout),
              label: Text(_signingOut ? '処理中...' : 'サインアウト'),
              onPressed: _signingOut ? null : _signOut,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
