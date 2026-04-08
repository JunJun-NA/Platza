import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:platza/domain/enums/enums.dart';

part 'care_log.freezed.dart';
part 'care_log.g.dart';

/// お世話の履歴データ
@freezed
abstract class CareLog with _$CareLog {
  const factory CareLog({
    required String id,
    required String plantId,
    required CareType careType,
    required DateTime performedAt,
    String? note,
  }) = _CareLog;

  factory CareLog.fromJson(Map<String, dynamic> json) =>
      _$CareLogFromJson(json);
}
