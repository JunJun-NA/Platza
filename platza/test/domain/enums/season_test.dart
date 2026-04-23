import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/enums/season.dart';

void main() {
  group('Season.fromDate', () {
    test('3月は春', () {
      expect(Season.fromDate(DateTime(2026, 3, 1)), Season.spring);
    });

    test('5月末日は春', () {
      expect(Season.fromDate(DateTime(2026, 5, 31)), Season.spring);
    });

    test('6月は夏', () {
      expect(Season.fromDate(DateTime(2026, 6, 1)), Season.summer);
    });

    test('8月末日は夏', () {
      expect(Season.fromDate(DateTime(2026, 8, 31)), Season.summer);
    });

    test('9月は秋', () {
      expect(Season.fromDate(DateTime(2026, 9, 1)), Season.autumn);
    });

    test('11月末日は秋', () {
      expect(Season.fromDate(DateTime(2026, 11, 30)), Season.autumn);
    });

    test('12月は冬', () {
      expect(Season.fromDate(DateTime(2026, 12, 1)), Season.winter);
    });

    test('1月は冬', () {
      expect(Season.fromDate(DateTime(2026, 1, 15)), Season.winter);
    });

    test('2月末日は冬', () {
      expect(Season.fromDate(DateTime(2026, 2, 28)), Season.winter);
    });
  });

  group('Season labels / emojis', () {
    test('すべての Season に label と emoji が定義されている', () {
      for (final season in Season.values) {
        expect(season.label, isNotEmpty);
        expect(season.emoji, isNotEmpty);
      }
    });
  });
}
