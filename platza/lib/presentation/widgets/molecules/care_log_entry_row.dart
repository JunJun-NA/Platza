import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/atoms/care_type_icon_container.dart';
import 'package:platza/presentation/widgets/molecules/platza_card.dart';

/// お世話ログ 1 件を 1 行で表示する行ウィジェット
///
/// 左: CareTypeIconContainer / 中央: ラベル + メモ / 右: 時刻文字列。
/// PlatzaCard でラップされており、[onTap] でタップ可能。
class CareLogEntryRow extends StatelessWidget {
  const CareLogEntryRow({
    super.key,
    required this.careType,
    required this.time,
    this.note,
    this.onTap,
  });

  final CareType careType;

  /// 実施時刻（例: "14:30"）
  final String time;

  /// 任意のメモ。null または空の場合は非表示。
  final String? note;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return PlatzaCard(
      onTap: onTap,
      child: Row(
        children: [
          CareTypeIconContainer(careType: careType),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  careType.label,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                if (note != null && note!.isNotEmpty)
                  Text(
                    note!,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
