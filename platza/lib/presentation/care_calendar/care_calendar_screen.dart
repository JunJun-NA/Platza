import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:platza/application/providers/care_calendar_providers.dart';
import 'package:platza/application/providers/plant_providers.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

/// 植物ごとのお世話カレンダー画面
///
/// 月間カレンダー上で実施済みログと次回予定日を区別して表示する。
class CareCalendarScreen extends ConsumerStatefulWidget {
  const CareCalendarScreen({super.key, required this.plantId});

  final String plantId;

  @override
  ConsumerState<CareCalendarScreen> createState() =>
      _CareCalendarScreenState();
}

class _CareCalendarScreenState extends ConsumerState<CareCalendarScreen> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedDay = DateTime(now.year, now.month, now.day);
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final plantAsync = ref.watch(plantByIdProvider(widget.plantId));
    final calendarAsync =
        ref.watch(careCalendarDataProvider(widget.plantId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          plantAsync.whenOrNull(data: (p) => p?.nickname ?? 'お世話カレンダー') ??
              'お世話カレンダー',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: calendarAsync.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('エラーが発生しました: $error')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CareCalendarData data) {
    final selected = _selectedDay ?? _focusedDay;
    final eventsOfSelected = data.eventsForDay(selected);

    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalendarCard(data),
          const SizedBox(height: AppSpacing.lg),
          _buildLegend(context),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '${_formatDate(selected)} のお世話',
            style: AppTypography.heading,
          ),
          const SizedBox(height: AppSpacing.sm),
          if (eventsOfSelected.isEmpty)
            _buildEmptyDay(context)
          else
            ...eventsOfSelected.map((e) => _buildEventCard(context, e)),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildCalendarCard(CareCalendarData data) {
    return PlatzaCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: TableCalendar<CareCalendarEvent>(
        locale: 'ja_JP',
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        eventLoader: data.eventsForDay,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableCalendarFormats: const {CalendarFormat.month: '月'},
        onDaySelected: (selected, focused) {
          setState(() {
            _selectedDay = selected;
            _focusedDay = focused;
          });
        },
        onPageChanged: (focused) {
          _focusedDay = focused;
        },
        calendarBuilders: CalendarBuilders<CareCalendarEvent>(
          markerBuilder: (context, day, events) {
            if (events.isEmpty) return const SizedBox.shrink();
            return _buildMarkers(events);
          },
        ),
        calendarStyle: const CalendarStyle(
          outsideDaysVisible: false,
          selectedDecoration: BoxDecoration(
            color: AppColors.primaryGreen,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  /// 1 日分のマーカーを表示（最大 4 種類、左上 + 右下にずらして配置）
  Widget _buildMarkers(List<CareCalendarEvent> events) {
    final seen = <CareType, CareCalendarEvent>{};
    for (final e in events) {
      // 実施済みのほうを優先的に残す
      final existing = seen[e.careType];
      if (existing == null || (!existing.isPerformed && e.isPerformed)) {
        seen[e.careType] = e;
      }
    }
    final markers = seen.values.take(4).toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: markers
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: _MarkerDot(event: e),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return const Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.xs,
      children: [
        _LegendItem(
          color: AppColors.careWater,
          label: '実施済み',
          isPerformed: true,
        ),
        _LegendItem(
          color: AppColors.textSubtle,
          label: '予定',
          isPerformed: false,
        ),
      ],
    );
  }

  Widget _buildEmptyDay(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Center(
        child: Text(
          'この日はお世話の記録も予定もありません',
          style: TextStyle(color: AppColors.textSubtle),
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, CareCalendarEvent event) {
    final color = _careTypeColor(event.careType);
    final note = event.log?.note;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: PlatzaCard(
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Center(
                child: Text(
                  event.careType.emoji,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.careType.label,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    event.isPerformed ? '実施済み' : '予定',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: event.isPerformed
                              ? AppColors.textSuccess
                              : AppColors.textSubtle,
                        ),
                  ),
                  if (note != null && note.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.xxs),
                      child: Text(
                        note,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            if (event.log != null)
              Text(
                _formatTime(event.log!.performedAt),
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }

  Color _careTypeColor(CareType type) {
    return switch (type) {
      CareType.water => AppColors.careWater,
      CareType.fertilize => AppColors.careFertilize,
      CareType.sunlight => AppColors.careSunlight,
      CareType.repot => AppColors.careRepot,
    };
  }

  String _formatDate(DateTime date) =>
      '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';

  String _formatTime(DateTime date) =>
      '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
}

class _MarkerDot extends StatelessWidget {
  const _MarkerDot({required this.event});

  final CareCalendarEvent event;

  @override
  Widget build(BuildContext context) {
    final baseColor = switch (event.careType) {
      CareType.water => AppColors.careWater,
      CareType.fertilize => AppColors.careFertilize,
      CareType.sunlight => AppColors.careSunlight,
      CareType.repot => AppColors.careRepot,
    };

    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: event.isPerformed ? baseColor : Colors.transparent,
        border: event.isPerformed
            ? null
            : Border.all(color: baseColor, width: 1.2),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    required this.isPerformed,
  });

  final Color color;
  final String label;
  final bool isPerformed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPerformed ? color : Colors.transparent,
            border: isPerformed ? null : Border.all(color: color, width: 1.2),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
