import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// 写真撮影・選択サービス
class PhotoService {
  PhotoService({
    ImagePicker? imagePicker,
  }) : _imagePicker = imagePicker ?? ImagePicker();

  final ImagePicker _imagePicker;

  /// カメラで撮影して写真を保存し、ファイルパスを返す
  Future<String?> pickFromCamera() async {
    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
      if (image == null) return null;
      return _saveToAppDirectory(image.path);
    } catch (_) {
      // シミュレータ等でカメラが利用できない場合
      return null;
    }
  }

  /// ギャラリーから選択して写真を保存し、ファイルパスを返す
  Future<String?> pickFromGallery() async {
    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
      if (image == null) return null;
      return _saveToAppDirectory(image.path);
    } catch (_) {
      return null;
    }
  }

  /// 写真ファイルを削除する
  Future<void> deletePhotoFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// 画像をアプリのドキュメントディレクトリにコピーし、パスを返す
  Future<String> _saveToAppDirectory(String sourcePath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory(p.join(appDir.path, 'photos'));
    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
    }

    final fileName = '${const Uuid().v4()}.jpg';
    final destPath = p.join(photosDir.path, fileName);
    await File(sourcePath).copy(destPath);
    return destPath;
  }

  /// テスト用: 保存先パスを生成するだけのヘルパー
  static String generatePhotoFileName() {
    return '${const Uuid().v4()}.jpg';
  }
}
