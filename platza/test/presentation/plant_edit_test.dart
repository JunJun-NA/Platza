import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/core/constants/app_routes.dart';
import 'package:platza/domain/entities/plant.dart';
import 'package:platza/domain/enums/enums.dart';

void main() {
  group('PlantEditScreen logic', () {
    group('AppRoutes.plantEditPath', () {
      test('generates correct edit path', () {
        expect(AppRoutes.plantEditPath('abc-123'), '/plant/abc-123/edit');
      });

      test('plantEdit route pattern is correct', () {
        expect(AppRoutes.plantEdit, '/plant/:id/edit');
      });
    });

    group('Plant copyWith for edit operations', () {
      late Plant basePlant;

      setUp(() {
        basePlant = Plant(
          id: 'plant-1',
          nickname: '元の名前',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime(2024, 1, 1),
          streakDays: 5,
        );
      });

      test('editing nickname preserves all other fields', () {
        final edited = basePlant.copyWith(nickname: '新しい名前');

        expect(edited.nickname, '新しい名前');
        expect(edited.id, basePlant.id);
        expect(edited.speciesId, basePlant.speciesId);
        expect(edited.location, basePlant.location);
        expect(edited.createdAt, basePlant.createdAt);
        expect(edited.streakDays, basePlant.streakDays);
        expect(edited.status, basePlant.status);
        expect(edited.growthStage, basePlant.growthStage);
      });

      test('editing location preserves all other fields', () {
        final edited = basePlant.copyWith(location: PlantLocation.outdoor);

        expect(edited.location, PlantLocation.outdoor);
        expect(edited.nickname, basePlant.nickname);
        expect(edited.id, basePlant.id);
        expect(edited.speciesId, basePlant.speciesId);
        expect(edited.streakDays, basePlant.streakDays);
      });
    });

    group('Delete confirmation dialog', () {
      testWidgets('cancel does not call delete', (tester) async {
        bool deleteCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('植物を削除'),
                        content: const Text(
                          '「テスト植物」を削除しますか？\nお世話ログやスケジュールも一緒に削除されます。',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('キャンセル'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('削除'),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      deleteCalled = true;
                    }
                  },
                  child: const Text('削除テスト'),
                ),
              ),
            ),
          ),
        );

        // Tap button to show dialog
        await tester.tap(find.text('削除テスト'));
        await tester.pumpAndSettle();

        // Verify dialog is shown
        expect(find.text('植物を削除'), findsOneWidget);
        expect(find.text('キャンセル'), findsOneWidget);
        expect(find.text('削除'), findsOneWidget);

        // Tap cancel
        await tester.tap(find.text('キャンセル'));
        await tester.pumpAndSettle();

        // Delete should not have been called
        expect(deleteCalled, isFalse);
      });

      testWidgets('confirm triggers delete', (tester) async {
        bool deleteCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('植物を削除'),
                        content: const Text(
                          '「テスト植物」を削除しますか？\nお世話ログやスケジュールも一緒に削除されます。',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('キャンセル'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('削除'),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      deleteCalled = true;
                    }
                  },
                  child: const Text('削除テスト'),
                ),
              ),
            ),
          ),
        );

        // Tap button to show dialog
        await tester.tap(find.text('削除テスト'));
        await tester.pumpAndSettle();

        // Tap delete
        await tester.tap(find.text('削除'));
        await tester.pumpAndSettle();

        // Delete should have been called
        expect(deleteCalled, isTrue);
      });

      testWidgets('dialog shows plant nickname in message', (tester) async {
        const nickname = 'マイサボテン';

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('植物を削除'),
                        content: const Text(
                          '「$nickname」を削除しますか？\nお世話ログやスケジュールも一緒に削除されます。',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('キャンセル'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('削除'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('削除テスト'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('削除テスト'));
        await tester.pumpAndSettle();

        // Verify nickname is in the dialog message
        expect(
          find.textContaining('マイサボテン'),
          findsOneWidget,
        );
      });
    });
  });
}
