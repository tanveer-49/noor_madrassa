// lib/models/notification_model.dart
class AppNotification {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;
  final String? actionId;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.actionId,
  });
}

enum NotificationType {
  dailyAyah,
  dailyHadith,
  prayerReminder,
  lessonReminder,
  streakReminder,
  achievement,
  general,
}

extension NotificationTypeExtension on NotificationType {
  String get label {
    switch (this) {
      case NotificationType.dailyAyah:
        return 'Daily Ayah';
      case NotificationType.dailyHadith:
        return 'Daily Hadith';
      case NotificationType.prayerReminder:
        return 'Prayer Reminder';
      case NotificationType.lessonReminder:
        return 'Lesson Reminder';
      case NotificationType.streakReminder:
        return 'Streak Reminder';
      case NotificationType.achievement:
        return 'Achievement';
      case NotificationType.general:
        return 'General';
    }
  }

  String get icon {
    switch (this) {
      case NotificationType.dailyAyah:
        return '📖';
      case NotificationType.dailyHadith:
        return '📚';
      case NotificationType.prayerReminder:
        return '🕌';
      case NotificationType.lessonReminder:
        return '🎓';
      case NotificationType.streakReminder:
        return '🔥';
      case NotificationType.achievement:
        return '🏆';
      case NotificationType.general:
        return '🔔';
    }
  }

  String get color {
    switch (this) {
      case NotificationType.dailyAyah:
        return '#0F5C4D';
      case NotificationType.dailyHadith:
        return '#187A64';
      case NotificationType.prayerReminder:
        return '#C7A44A';
      case NotificationType.lessonReminder:
        return '#2E7D32';
      case NotificationType.streakReminder:
        return '#8B6B3D';
      case NotificationType.achievement:
        return '#B8860B';
      case NotificationType.general:
        return '#4A5A55';
    }
  }
}

class NotificationSettings {
  final bool dailyAyahEnabled;
  final bool dailyHadithEnabled;
  final bool prayerRemindersEnabled;
  final bool lessonRemindersEnabled;
  final bool streakRemindersEnabled;
  final bool achievementsEnabled;
  final String dailyAyahTime;
  final String dailyHadithTime;

  NotificationSettings({
    this.dailyAyahEnabled = true,
    this.dailyHadithEnabled = true,
    this.prayerRemindersEnabled = true,
    this.lessonRemindersEnabled = true,
    this.streakRemindersEnabled = true,
    this.achievementsEnabled = true,
    this.dailyAyahTime = '08:00',
    this.dailyHadithTime = '20:00',
  });

  NotificationSettings copyWith({
    bool? dailyAyahEnabled,
    bool? dailyHadithEnabled,
    bool? prayerRemindersEnabled,
    bool? lessonRemindersEnabled,
    bool? streakRemindersEnabled,
    bool? achievementsEnabled,
    String? dailyAyahTime,
    String? dailyHadithTime,
  }) {
    return NotificationSettings(
      dailyAyahEnabled: dailyAyahEnabled ?? this.dailyAyahEnabled,
      dailyHadithEnabled: dailyHadithEnabled ?? this.dailyHadithEnabled,
      prayerRemindersEnabled: prayerRemindersEnabled ?? this.prayerRemindersEnabled,
      lessonRemindersEnabled: lessonRemindersEnabled ?? this.lessonRemindersEnabled,
      streakRemindersEnabled: streakRemindersEnabled ?? this.streakRemindersEnabled,
      achievementsEnabled: achievementsEnabled ?? this.achievementsEnabled,
      dailyAyahTime: dailyAyahTime ?? this.dailyAyahTime,
      dailyHadithTime: dailyHadithTime ?? this.dailyHadithTime,
    );
  }
}