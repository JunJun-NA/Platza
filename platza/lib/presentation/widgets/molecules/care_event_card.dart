import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/atoms/care_type_icon_container.dart';
import 'package:platza/presentation/widgets/molecules/platza_card.dart';

/// カレンダーの 1 イベント行（実施済み / 予定）を表示するカード
///
/// `care_calendar` の日次リストで使用。`CareLogEntryRow` との違いは、
/// 「実施済み / 予定」ステータスラベルが表示される点と、時刻が任意である点。
class CareEventCard extends StatelessWidget {
  const CareEventCard({
    super.key,
    required this.careType,
    required this.isPerformed,
    this.note,
    this.time,
  });

  final CareType careType;
  final bool isPerformed;

  /// ログの自由記述メモ。null または空の場合は非表示。
  final String? note;

  /// 実施時刻（例: "14:30"）。[isPerformed]=true かつ時刻が分かる場合のみ渡す。
  final String? time;

  @override
  Widget build(BuildContext context) {
    return PlatzaCard(
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
                Text(
                  isPerformed ? '実施済み' : '予定',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isPerformed
                            ? AppColors.textSuccess
                            : AppColors.textSubtle,
                      ),
                ),
                if (note != null && note!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xxs),
                    child: Text(
                      note!,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
          if (time != null)
            Text(
              time!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}
