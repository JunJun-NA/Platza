import 'package:flutter_test/flutter_test.dart';
import 'package:platza/infrastructure/services/photo_service.dart';

void main() {
  group('PhotoService', () {
    group('generatePhotoFileName', () {
      test('generates a .jpg filename', () {
        final fileName = PhotoService.generatePhotoFileName();
        expect(fileName.endsWith('.jpg'), isTrue);
      });

      test('generates unique filenames', () {
        final names = <String>{};
        for (var i = 0; i < 100; i++) {
          names.add(PhotoService.generatePhotoFileName());
        }
        // All 100 should be unique
        expect(names.length, 100);
      });

      test('filename matches UUID format with .jpg extension', () {
        final fileName = PhotoService.generatePhotoFileName();
        // UUID v4 format: 8-4-4-4-12 hex chars
        final uuidPart = fileName.replaceAll('.jpg', '');
        final uuidRegex = RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
        );
        expect(uuidRegex.hasMatch(uuidPart), isTrue);
      });
    });

    test('PhotoService can be created with default ImagePicker', () {
      // Should not throw
      final service = PhotoService();
      expect(service, isNotNull);
    });
  });
}
