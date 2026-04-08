import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:platza/domain/enums/enums.dart';

part 'care_schedule.freezed.dart';
part 'care_schedule.g.dart';

/// お世話のスケジュール設定
@freezed
abstract class CareSchedule with _$CareSchedule {
  const factory CareSchedule({
    required String id,
    required String plantId,
    required CareType careType,
    required int intervalDays,
    required DateTime nextDueDate,
    @Default(true) bool isEnabled,
  }) = _CareSchedule;

  factory CareSchedule.fromJson(Map<String, dynamic> json) =>
      _$CareScheduleFromJson(json);
}
