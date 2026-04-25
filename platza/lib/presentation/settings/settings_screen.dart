import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/application/providers/notification_providers.dart';
import 'package:platza/application/providers/user_settings_providers.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/presentation/account/account_link_section.dart';
import 'package:platza/presentation/widgets/widgets.dart';

/// 設定画面 - 通知・テーマなどの設定
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(userSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: settingsAsync.when(
        data: (settings) => _buildSettingsList(context, ref, settings),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('エラーが発生しました: $error')),
      ),
    );
  }

  Widget _buildSettingsList(
    BuildContext context,
    WidgetRef ref,
    UserSettings settings,
  ) {
    return ListView(
      children: [
        const SectionHeader(title: 'アカウント'),
        const AccountLinkSection(),
        const Divider(),
        const SectionHeader(title: '通知'),
        SwitchListTile(
          title: const Text('通知を有効にする'),
          subtitle: const Text('水やり・肥料のリマインダーを受け取ります'),
          value: settings.notificationEnabled,
          onChanged: (value) async {
            await updateUserSettings(
              ref,
              settings.copyWith(notificationEnabled: value),
            );
            if (value) {
              // 通知ON: 全お世話リマインダーをスケジュール
              await scheduleAllCareNotificationsFromWidget(ref);
            } else {
              // 通知OFF: 全通知をキャンセル
              final notificationService =
                  ref.read(notificationServiceProvider);
              await notificationService.cancelAllNotifications();
            }
          },
        ),
        ListTile(
          title: const Text('リマインダー時刻'),
          subtitle: Text(
            '${settings.waterReminderHour.toString().padLeft(2, '0')}:'
            '${settings.waterReminderMinute.toString().padLeft(2, '0')}',
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                hour: settings.waterReminderHour,
                minute: settings.waterReminderMinute,
              ),
            );
            if (time != null) {
              updateUserSettings(
                ref,
                settings.copyWith(
                  waterReminderHour: time.hour,
                  waterReminderMinute: time.minute,
                ),
              );
            }
          },
        ),
        SwitchListTile(
          title: const Text('肥料リマインダー'),
          subtitle: const Text('肥料の時期をお知らせします'),
          value: settings.fertilizerReminderEnabled,
          onChanged: (value) {
            updateUserSettings(
              ref,
              settings.copyWith(fertilizerReminderEnabled: value),
            );
          },
        ),
        const Divider(),
        const SectionHeader(title: '表示'),
        SwitchListTile(
          title: const Text('ダークモード'),
          value: settings.isDarkMode,
          onChanged: (value) {
            updateUserSettings(
              ref,
              settings.copyWith(isDarkMode: value),
            );
          },
        ),
        const Divider(),
        const SectionHeader(title: 'アプリ情報'),
        const ListTile(
          title: Text('バージョン'),
          subtitle: Text('0.1.0'),
        ),
        ListTile(
          title: const Text('ライセンス'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            showLicensePage(context: context);
          },
        ),
      ],
    );
  }
}
