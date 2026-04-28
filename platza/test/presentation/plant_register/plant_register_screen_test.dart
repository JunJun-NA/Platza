import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:platza/presentation/plant_register/plant_register_screen.dart';

void main() {
  group('writeWithSyncTimeout', () {
    test('タイムアウト前に解決した write はそのまま完了する', () async {
      var completed = false;
      await writeWithSyncTimeout(
        Future<void>.delayed(
          const Duration(milliseconds: 10),
          () => completed = true,
        ),
        timeout: const Duration(seconds: 1),
      );

      expect(completed, isTrue);
    });

    test('解決しない write はタイムアウトでも例外を投げず完了する', () async {
      // Firestore の set() がオフライン時にサーバー ACK を待ち続ける状況を
      // 模した、解決しない Future。
      final pending = Completer<void>().future;

      await expectLater(
        writeWithSyncTimeout(
          pending,
          timeout: const Duration(milliseconds: 50),
        ),
        completes,
      );
    });

    test('タイムアウト以外の例外はそのまま再スローされる', () async {
      Future<void> failing() => Future<void>.error(StateError('boom'));

      await expectLater(
        writeWithSyncTimeout(failing()),
        throwsA(isA<StateError>()),
      );
    });
  });
}
