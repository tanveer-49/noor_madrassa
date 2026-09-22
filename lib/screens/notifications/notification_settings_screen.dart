// lib/screens/notifications/notification_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/services/notification_service.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  final NotificationService _notificationService = Get.find();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Notification Settings',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 18),
            color: context.textColor,
          ),
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.padding(context, 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reminders Section
            _buildSection(
              context,
              isDark,
              'Reminders',
              [
                _buildSwitchItem(
                  context,
                  isDark,
                  '📖',
                  'Daily Ayah',
                  'Get daily Qur\'an verse notification',
                  _notificationService.settings.value.dailyAyahEnabled,
                      (value) => _notificationService.toggleDailyAyah(value),
                ),
                _buildSwitchItem(
                  context,
                  isDark,
                  '📚',
                  'Daily Hadith',
                  'Get daily Hadith notification',
                  _notificationService.settings.value.dailyHadithEnabled,
                      (value) => _notificationService.toggleDailyHadith(value),
                ),
                _buildSwitchItem(
                  context,
                  isDark,
                  '🕌',
                  'Prayer Reminders',
                  'Get notified for prayer times',
                  _notificationService.settings.value.prayerRemindersEnabled,
                      (value) =>
                      _notificationService.togglePrayerReminders(value),
                ),
                _buildSwitchItem(
                  context,
                  isDark,
                  '🔥',
                  'Streak Reminders',
                  'Keep your learning streak alive',
                  _notificationService.settings.value.streakRemindersEnabled,
                      (value) =>
                      _notificationService.toggleStreakReminders(value),
                ),
              ],
            ),

            SizedBox(height: Responsive.height(context, 16)),

            // Learning Section
            _buildSection(
              context,
              isDark,
              'Learning',
              [
                _buildSwitchItem(
                  context,
                  isDark,
                  '🎓',
                  'Lesson Reminders',
                  'Remind me to continue lessons',
                  _notificationService.settings.value.lessonRemindersEnabled,
                      (value) =>
                      _notificationService.toggleLessonReminders(value),
                ),
                _buildSwitchItem(
                  context,
                  isDark,
                  '🏆',
                  'Achievements',
                  'Notify when I earn badges',
                  _notificationService.settings.value.achievementsEnabled,
                      (value) => _notificationService.toggleAchievements(value),
                ),
              ],
            ),

            SizedBox(height: Responsive.height(context, 16)),

            // Timing Section
            _buildSection(
              context,
              isDark,
              'Timing',
              [
                _buildTimeItem(
                  context,
                  isDark,
                  '📖',
                  'Daily Ayah Time',
                  _notificationService.settings.value.dailyAyahTime,
                      (time) =>
                      _notificationService.updateDailyAyahTime(time),
                ),
                _buildTimeItem(
                  context,
                  isDark,
                  '📚',
                  'Daily Hadith Time',
                  _notificationService.settings.value.dailyHadithTime,
                      (time) =>
                      _notificationService.updateDailyHadithTime(time),
                ),
              ],
            ),

            SizedBox(height: Responsive.height(context, 24)),

            // Info Card
            Container(
              padding: EdgeInsets.all(Responsive.padding(context, 14)),
              decoration: BoxDecoration(
                color: AppColors.emerald.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.emerald.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.emerald,
                    size: Responsive.width(context, 20),
                  ),
                  SizedBox(width: Responsive.padding(context, 10)),
                  Expanded(
                    child: Text(
                      'Notifications will be delivered based on your device settings and preferences.',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 12),
                        color: context.textSecondaryColor,
                        height: 1.5,
                      ),
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

  // ==================== SECTION BUILDER ====================
  Widget _buildSection(
      BuildContext context,
      bool isDark,
      String title,
      List<Widget> children,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.w600,
            color: context.textSecondaryColor,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: Responsive.height(context, 8)),
        Container(
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(isDark ? 0.1 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  // ==================== SWITCH ITEM BUILDER ====================
  Widget _buildSwitchItem(
      BuildContext context,
      bool isDark,
      String emoji,
      String title,
      String subtitle,
      bool value,
      Function(bool) onChanged,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.padding(context, 16),
        vertical: Responsive.padding(context, 12),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: Responsive.fontSize(context, 20)),
          ),
          SizedBox(width: Responsive.padding(context, 14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    fontWeight: FontWeight.w500,
                    color: context.textColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 11),
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.emerald,
          ),
        ],
      ),
    );
  }

  // ==================== TIME ITEM BUILDER ====================
  Widget _buildTimeItem(
      BuildContext context,
      bool isDark,
      String emoji,
      String title,
      String time,
      Function(String) onTimeChanged,
      ) {
    return GestureDetector(
      onTap: () async {
        final parts = time.split(':');
        final initialTime = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );

        final picked = await showTimePicker(
          context: context,
          initialTime: initialTime,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.emerald,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          final formatted =
              '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
          onTimeChanged(formatted);
          setState(() {});
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.padding(context, 16),
          vertical: Responsive.padding(context, 14),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: Responsive.fontSize(context, 20)),
            ),
            SizedBox(width: Responsive.padding(context, 14)),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  fontWeight: FontWeight.w500,
                  color: context.textColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.padding(context, 12),
                vertical: Responsive.padding(context, 6),
              ),
              decoration: BoxDecoration(
                color: AppColors.emerald.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 13),
                  color: AppColors.emerald,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}