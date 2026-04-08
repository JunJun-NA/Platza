import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:platza/domain/entities/identification_result.dart';

/// 植物種同定サービス（Claude Vision API使用）
class PlantIdentificationService {
  PlantIdentificationService({
    String? apiKey,
    http.Client? httpClient,
  })  : _apiKey = apiKey ??
            const String.fromEnvironment('ANTHROPIC_API_KEY'),
        _httpClient = httpClient ?? http.Client();

  final String _apiKey;
  final http.Client _httpClient;

  static const _apiUrl = 'https://api.anthropic.com/v1/messages';
  static const _model = 'claude-haiku-4-5-20251001';

  /// サポートされている種のリスト
  static const supportedSpecies = [
    {'id': 'echeveria', 'name': 'エケベリア'},
    {'id': 'sedum', 'name': 'セダム'},
    {'id': 'haworthia', 'name': 'ハオルチア'},
    {'id': 'graptopetallum', 'name': 'グラプトペタルム'},
    {'id': 'aloe', 'name': 'アロエ'},
    {'id': 'cactus_round', 'name': '丸型サボテン'},
    {'id': 'cactus_pillar', 'name': '柱サボテン'},
    {'id': 'cactus_paddle', 'name': 'ウチワサボテン'},
    {'id': 'cactus_star', 'name': '星形サボテン'},
    {'id': 'cactus_ball', 'name': '玉サボテン'},
  ];

  /// プロンプトを生成する
  String buildPrompt() {
    final speciesListStr = supportedSpecies
        .map((s) => '- ${s['id']}: ${s['name']}')
        .join('\n');

    return '''この写真の植物を以下のサポート対象種から同定してください。

サポート対象種:
$speciesListStr

以下のJSON形式のみで回答してください（他のテキストは不要）:
{"candidates":[{"speciesId":"種ID","name":"種名","confidence":0.0~1.0の信頼度}]}

最も可能性の高い候補を最大3つ、confidence降順で返してください。
写真が植物でない場合や判別できない場合は空の候補リストを返してください。''';
  }

  /// 写真ファイルから植物を同定する
  Future<IdentificationResult> identify(String imagePath) async {
    if (_apiKey.isEmpty) {
      return IdentificationResult.error(
        'APIキーが設定されていません。--dart-define=ANTHROPIC_API_KEY=... を指定してください。',
      );
    }

    try {
      final file = File(imagePath);
      if (!await file.exists()) {
        return IdentificationResult.error('画像ファイルが見つかりません。');
      }

      final bytes = await file.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await _httpClient.post(
        Uri.parse(_apiUrl),
        headers: {
          'x-api-key': _apiKey,
          'anthropic-version': '2023-06-01',
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'model': _model,
          'max_tokens': 256,
          'messages': [
            {
              'role': 'user',
              'content': [
                {
                  'type': 'image',
                  'source': {
                    'type': 'base64',
                    'media_type': 'image/jpeg',
                    'data': base64Image,
                  },
                },
                {
                  'type': 'text',
                  'text': buildPrompt(),
                },
              ],
            },
          ],
        }),
      );

      if (response.statusCode != 200) {
        return IdentificationResult.error(
          'API呼び出しに失敗しました (${response.statusCode})',
        );
      }

      return _parseResponse(response.body);
    } on SocketException {
      return IdentificationResult.error('ネットワークに接続できません。');
    } catch (e) {
      return IdentificationResult.error('エラーが発生しました: $e');
    }
  }

  /// APIレスポンスを解析する
  IdentificationResult _parseResponse(String responseBody) {
    try {
      final json = jsonDecode(responseBody) as Map<String, dynamic>;
      final content = json['content'] as List<dynamic>;
      if (content.isEmpty) {
        return IdentificationResult.error('APIからの応答が空です。');
      }

      final textBlock = content.firstWhere(
        (block) => block['type'] == 'text',
        orElse: () => null,
      );
      if (textBlock == null) {
        return IdentificationResult.error('APIからのテキスト応答が見つかりません。');
      }

      final text = (textBlock['text'] as String).trim();
      return parseIdentificationJson(text);
    } catch (e) {
      return IdentificationResult.error('応答の解析に失敗しました: $e');
    }
  }

  /// JSON文字列から同定結果を解析する（テスト可能にstatic公開）
  static IdentificationResult parseIdentificationJson(String text) {
    try {
      final resultJson = jsonDecode(text) as Map<String, dynamic>;
      final candidatesJson = resultJson['candidates'] as List<dynamic>;

      final candidates = candidatesJson.map((c) {
        final map = c as Map<String, dynamic>;
        return IdentificationCandidate(
          speciesId: map['speciesId'] as String,
          name: map['name'] as String,
          confidence: (map['confidence'] as num).toDouble(),
        );
      }).toList();

      return IdentificationResult(candidates: candidates);
    } catch (e) {
      return IdentificationResult.error('応答JSONの解析に失敗しました: $e');
    }
  }
}
