import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http_testing;
import 'package:platza/infrastructure/services/plant_identification_service.dart';

void main() {
  group('PlantIdentificationService', () {
    group('APIキーが未設定の場合', () {
      test('エラー結果を返す', () async {
        final service = PlantIdentificationService(apiKey: '');
        final result = await service.identify('/dummy/path.jpg');

        expect(result.isError, true);
        expect(result.errorMessage, contains('APIキーが設定されていません'));
      });
    });

    group('APIエラーレスポンスの場合', () {
      test('ステータスコード非200でエラー結果を返す', () async {
        // テスト用の一時画像ファイルを作成
        final tempDir = Directory.systemTemp;
        final tempFile = File('${tempDir.path}/test_image_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await tempFile.writeAsBytes([0xFF, 0xD8, 0xFF, 0xE0]); // minimal JPEG header

        try {
          final mockClient = http_testing.MockClient((request) async {
            return http.Response('{"error": "unauthorized"}', 401);
          });

          final service = PlantIdentificationService(
            apiKey: 'test-key',
            httpClient: mockClient,
          );
          final result = await service.identify(tempFile.path);

          expect(result.isError, true);
          expect(result.errorMessage, contains('401'));
        } finally {
          await tempFile.delete();
        }
      });
    });

    group('正常なAPIレスポンスの場合', () {
      test('候補リストが正しくパースされる', () async {
        final tempDir = Directory.systemTemp;
        final tempFile = File('${tempDir.path}/test_image_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await tempFile.writeAsBytes([0xFF, 0xD8, 0xFF, 0xE0]);

        try {
          final responseJson = jsonEncode({
            'content': [
              {
                'type': 'text',
                'text': jsonEncode({
                  'candidates': [
                    {
                      'speciesId': 'echeveria',
                      'name': 'エケベリア',
                      'confidence': 0.85,
                    },
                    {
                      'speciesId': 'sedum',
                      'name': 'セダム',
                      'confidence': 0.10,
                    },
                  ],
                }),
              },
            ],
          });

          final mockClient = http_testing.MockClient((request) async {
            return http.Response.bytes(
              utf8.encode(responseJson),
              200,
              headers: {'content-type': 'application/json; charset=utf-8'},
            );
          });

          final service = PlantIdentificationService(
            apiKey: 'test-key',
            httpClient: mockClient,
          );
          final result = await service.identify(tempFile.path);

          expect(result.isError, false, reason: result.errorMessage);
          expect(result.candidates, hasLength(2));
          expect(result.candidates[0].speciesId, 'echeveria');
          expect(result.candidates[0].name, 'エケベリア');
          expect(result.candidates[0].confidence, 0.85);
          expect(result.candidates[1].speciesId, 'sedum');
        } finally {
          await tempFile.delete();
        }
      });
    });

    group('ファイルが存在しない場合', () {
      test('エラー結果を返す', () async {
        final service = PlantIdentificationService(apiKey: 'test-key');
        final result = await service.identify('/nonexistent/path.jpg');

        expect(result.isError, true);
        expect(result.errorMessage, contains('画像ファイルが見つかりません'));
      });
    });

    group('不正なAPIレスポンスの場合', () {
      test('不正なJSON応答でエラー結果を返す', () async {
        final tempDir = Directory.systemTemp;
        final tempFile = File('${tempDir.path}/test_image_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await tempFile.writeAsBytes([0xFF, 0xD8, 0xFF, 0xE0]);

        try {
          final mockClient = http_testing.MockClient((request) async {
            return http.Response('not json at all', 200);
          });

          final service = PlantIdentificationService(
            apiKey: 'test-key',
            httpClient: mockClient,
          );
          final result = await service.identify(tempFile.path);

          expect(result.isError, true);
          expect(result.errorMessage, contains('解析に失敗'));
        } finally {
          await tempFile.delete();
        }
      });
    });
  });

  group('parseIdentificationJson', () {
    test('正しいJSONをパースできる', () {
      final json = jsonEncode({
        'candidates': [
          {'speciesId': 'aloe', 'name': 'アロエ', 'confidence': 0.95},
        ],
      });

      final result = PlantIdentificationService.parseIdentificationJson(json);

      expect(result.isError, false);
      expect(result.candidates, hasLength(1));
      expect(result.candidates[0].speciesId, 'aloe');
      expect(result.candidates[0].confidence, 0.95);
    });

    test('空の候補リストを正しくパースできる', () {
      final json = jsonEncode({'candidates': []});

      final result = PlantIdentificationService.parseIdentificationJson(json);

      expect(result.isError, false);
      expect(result.candidates, isEmpty);
    });

    test('不正なJSONでエラー結果を返す', () {
      final result = PlantIdentificationService.parseIdentificationJson(
        'this is not json',
      );

      expect(result.isError, true);
      expect(result.errorMessage, contains('解析に失敗'));
    });

    test('必須フィールドが欠けているJSONでエラー結果を返す', () {
      final json = jsonEncode({
        'candidates': [
          {'speciesId': 'aloe'},
        ],
      });

      final result = PlantIdentificationService.parseIdentificationJson(json);

      expect(result.isError, true);
    });
  });

  group('buildPrompt', () {
    test('全10種がプロンプトに含まれる', () {
      final service = PlantIdentificationService(apiKey: 'test');
      final prompt = service.buildPrompt();

      expect(prompt, contains('echeveria'));
      expect(prompt, contains('sedum'));
      expect(prompt, contains('haworthia'));
      expect(prompt, contains('graptopetallum'));
      expect(prompt, contains('aloe'));
      expect(prompt, contains('cactus_round'));
      expect(prompt, contains('cactus_pillar'));
      expect(prompt, contains('cactus_paddle'));
      expect(prompt, contains('cactus_star'));
      expect(prompt, contains('cactus_ball'));
    });

    test('JSON形式の指示が含まれる', () {
      final service = PlantIdentificationService(apiKey: 'test');
      final prompt = service.buildPrompt();

      expect(prompt, contains('JSON'));
      expect(prompt, contains('candidates'));
      expect(prompt, contains('speciesId'));
      expect(prompt, contains('confidence'));
    });
  });

  group('supportedSpecies', () {
    test('10種のデータが含まれる', () {
      expect(PlantIdentificationService.supportedSpecies, hasLength(10));
    });
  });
}
