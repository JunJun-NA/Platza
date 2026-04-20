import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/entities/plant_photo.dart';

/// 写真フルスクリーンビューアダイアログ
class PhotoViewerDialog extends StatelessWidget {
  const PhotoViewerDialog({
    super.key,
    required this.photo,
    required this.onDelete,
  });

  final PlantPhoto photo;
  final Future<void> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat('yyyy/MM/dd HH:mm').format(photo.createdAt);

    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmDelete(context),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: InteractiveViewer(
                child: Center(
                  child: Image.file(
                    File(photo.filePath),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 64,
                        color: AppColors.textSubtle,
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (photo.caption != null && photo.caption!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Text(
                        photo.caption!,
                        style: AppTypography.bodyLarge,
                      ),
                    ),
                  Text(
                    dateText,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSubtle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('写真を削除'),
        content: const Text('この写真を削除してもよろしいですか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await onDelete();
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textDanger,
            ),
            child: const Text('削除'),
          ),
        ],
      ),
    );
  }
}
