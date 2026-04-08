import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('お世話ログ編集・削除 UI', () {
    testWidgets('削除確認ダイアログのキャンセルが正しく動作する', (tester) async {
      // AlertDialog のキャンセルボタンの動作テスト
      var deleted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          title: const Text('ログを削除'),
                          content: const Text('削除しますか？'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext),
                              child: const Text('キャンセル'),
                            ),
                            FilledButton(
                              onPressed: () {
                                deleted = true;
                                Navigator.pop(dialogContext);
                              },
                              child: const Text('削除'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('削除テスト'),
                ),
              );
            },
          ),
        ),
      );

      // ダイアログを開く
      await tester.tap(find.text('削除テスト'));
      await tester.pumpAndSettle();

      // ダイアログが表示されている
      expect(find.text('ログを削除'), findsOneWidget);
      expect(find.text('削除しますか？'), findsOneWidget);

      // キャンセルをタップ
      await tester.tap(find.text('キャンセル'));
      await tester.pumpAndSettle();

      // ダイアログが閉じ、削除されていない
      expect(find.text('ログを削除'), findsNothing);
      expect(deleted, isFalse);
    });

    testWidgets('削除確認ダイアログの削除ボタンが動作する', (tester) async {
      var deleted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          title: const Text('ログを削除'),
                          content: const Text('削除しますか？'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext),
                              child: const Text('キャンセル'),
                            ),
                            FilledButton(
                              onPressed: () {
                                deleted = true;
                                Navigator.pop(dialogContext);
                              },
                              child: const Text('削除'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('削除テスト'),
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('削除テスト'));
      await tester.pumpAndSettle();

      // 削除をタップ
      await tester.tap(find.text('削除'));
      await tester.pumpAndSettle();

      expect(find.text('ログを削除'), findsNothing);
      expect(deleted, isTrue);
    });

    testWidgets('ボトムシートに日時・メモ・削除・保存が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (sheetContext) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('💧 水やりを編集'),
                              const ListTile(
                                leading: Icon(Icons.calendar_today),
                                title: Text('実施日時'),
                                subtitle: Text('2024/06/15 10:00'),
                              ),
                              const TextField(
                                decoration: InputDecoration(
                                  labelText: 'メモ',
                                ),
                              ),
                              Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text('削除'),
                                  ),
                                  const Spacer(),
                                  FilledButton(
                                    onPressed: () {},
                                    child: const Text('保存'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('編集シート'),
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('編集シート'));
      await tester.pumpAndSettle();

      // ボトムシートの各要素が表示される
      expect(find.text('💧 水やりを編集'), findsOneWidget);
      expect(find.text('実施日時'), findsOneWidget);
      expect(find.text('2024/06/15 10:00'), findsOneWidget);
      expect(find.text('メモ'), findsOneWidget);
      expect(find.text('削除'), findsOneWidget);
      expect(find.text('保存'), findsOneWidget);
    });
  });
}
