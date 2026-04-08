import 'package:flutter_test/flutter_test.dart';
import 'package:platza/core/theme/app_theme.dart';

void main() {
  group('App smoke test', () {
    test('AppTheme.light can be created', () {
      final theme = AppTheme.light;
      expect(theme, isNotNull);
      expect(theme.useMaterial3, isTrue);
    });

    test('AppTheme.dark can be created', () {
      final theme = AppTheme.dark;
      expect(theme, isNotNull);
      expect(theme.useMaterial3, isTrue);
    });
  });
}
