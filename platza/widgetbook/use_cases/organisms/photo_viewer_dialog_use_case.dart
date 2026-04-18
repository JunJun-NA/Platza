import 'package:flutter/material.dart';
import 'package:platza/domain/entities/plant_photo.dart';
import 'package:platza/presentation/widgets/organisms/photo_viewer_dialog.dart';
import 'package:uuid/uuid.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// 写真ビューアはフルスクリーンの Dialog 表示のため、
/// Widgetbook 上ではトリガー用ボタンを介して開く。
/// 実ファイルは参照できないため、存在しないパスを渡して errorBuilder の見た目を確認する。
@widgetbook.UseCase(name: 'Launcher (error placeholder)', type: PhotoViewerDialog)
Widget photoViewerDialogLauncher(BuildContext context) {
  final caption = context.knobs.string(
    label: 'caption',
    initialValue: '新芽が出た！',
  );
  final photo = PlantPhoto(
    id: const Uuid().v4(),
    plantId: 'preview',
    filePath: '/nonexistent/placeholder.jpg',
    caption: caption,
    createdAt: DateTime.now(),
  );

  return Builder(
    builder: (ctx) => FilledButton.icon(
      icon: const Icon(Icons.photo),
      label: const Text('写真ビューアを開く'),
      onPressed: () {
        showDialog<void>(
          context: ctx,
          builder: (_) => PhotoViewerDialog(
            photo: photo,
            onDelete: () async {},
          ),
        );
      },
    ),
  );
}
