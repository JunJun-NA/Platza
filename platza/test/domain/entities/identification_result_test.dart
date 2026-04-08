import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/identification_result.dart';

void main() {
  group('IdentificationCandidate', () {
    test('正しく生成される', () {
      const candidate = IdentificationCandidate(
        speciesId: 'echeveria',
        name: 'エケベリア',
        confidence: 0.85,
      );

      expect(candidate.speciesId, 'echeveria');
      expect(candidate.name, 'エケベリア');
      expect(candidate.confidence, 0.85);
    });

    test('同値のインスタンスは等しい', () {
      const a = IdentificationCandidate(
        speciesId: 'sedum',
        name: 'セダム',
        confidence: 0.7,
      );
      const b = IdentificationCandidate(
        speciesId: 'sedum',
        name: 'セダム',
        confidence: 0.7,
      );

      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('異なるインスタンスは等しくない', () {
      const a = IdentificationCandidate(
        speciesId: 'sedum',
        name: 'セダム',
        confidence: 0.7,
      );
      const b = IdentificationCandidate(
        speciesId: 'aloe',
        name: 'アロエ',
        confidence: 0.5,
      );

      expect(a, isNot(equals(b)));
    });

    test('toStringが正しく動作する', () {
      const candidate = IdentificationCandidate(
        speciesId: 'echeveria',
        name: 'エケベリア',
        confidence: 0.85,
      );

      expect(candidate.toString(), contains('echeveria'));
      expect(candidate.toString(), contains('エケベリア'));
    });
  });

  group('IdentificationResult', () {
    test('候補リスト付きで生成される', () {
      const result = IdentificationResult(
        candidates: [
          IdentificationCandidate(
            speciesId: 'echeveria',
            name: 'エケベリア',
            confidence: 0.9,
          ),
          IdentificationCandidate(
            speciesId: 'sedum',
            name: 'セダム',
            confidence: 0.1,
          ),
        ],
      );

      expect(result.candidates, hasLength(2));
      expect(result.isError, false);
      expect(result.errorMessage, isNull);
    });

    test('デフォルトは空の候補リストでエラーなし', () {
      const result = IdentificationResult();

      expect(result.candidates, isEmpty);
      expect(result.isError, false);
      expect(result.errorMessage, isNull);
    });

    test('errorファクトリでエラー結果が生成される', () {
      final result = IdentificationResult.error('テストエラー');

      expect(result.candidates, isEmpty);
      expect(result.isError, true);
      expect(result.errorMessage, 'テストエラー');
    });
  });
}
