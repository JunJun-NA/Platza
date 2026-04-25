import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:platza/application/providers/auth_providers.dart';
import 'package:platza/infrastructure/services/auth_service.dart';

/// メール / パスワードでアカウントを連携・サインインするダイアログ。
///
/// 匿名状態なら現在の uid を保持してアップグレード、それ以外は通常サインインする。
class EmailLinkDialog extends ConsumerStatefulWidget {
  const EmailLinkDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const EmailLinkDialog(),
    );
  }

  @override
  ConsumerState<EmailLinkDialog> createState() => _EmailLinkDialogState();
}

class _EmailLinkDialogState extends ConsumerState<EmailLinkDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _submitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _submitting = true;
      _errorMessage = null;
    });

    try {
      await ref.read(authServiceProvider).linkWithEmail(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = authErrorMessage(e);
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('メールで連携'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(
                labelText: 'メールアドレス',
              ),
              validator: (v) {
                final value = v?.trim() ?? '';
                if (value.isEmpty) return 'メールアドレスを入力してください';
                if (!value.contains('@')) return 'メールアドレスの形式が正しくありません';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              autofillHints: const [AutofillHints.password],
              decoration: const InputDecoration(
                labelText: 'パスワード',
              ),
              validator: (v) {
                final value = v ?? '';
                if (value.length < 6) return '6 文字以上で入力してください';
                return null;
              },
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 12),
            const Text(
              '初めて使うメールアドレスは新規登録、既存のアカウントはサインインします。',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: _submitting ? null : _submit,
          child: _submitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('連携する'),
        ),
      ],
    );
  }
}
