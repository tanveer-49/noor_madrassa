// lib/services/notification_service.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/notification_model.dart';
import '../data/notifications_data.dart';

class NotificationService extends GetxService {
  final GetStorage _storage = GetStorage();

  final RxList<AppNotification> notifications = <AppNotification>[].obs;
  final Rx<NotificationSettings> settings = NotificationSettings().obs;
  final Rx<NotificationType?> selectedFilter = Rx<NotificationType?>(null);

  @override
  void onInit() {
    super.onInit();
    notifications.value = dummyNotifications;
    _loadSettings();
  }

  // ==================== SETTINGS ====================

  void _loadSettings() {
    final saved = _storage.read('notificationSettings');
    if (saved != null) {
      settings.value = NotificationSettings(
        dailyAyahEnabled: saved['dailyAyahEnabled'] ?? true,
        dailyHadithEnabled: saved['dailyHadithEnabled'] ?? true,
        prayerRemindersEnabled: saved['prayerRemindersEnabled'] ?? true,
        lessonRemindersEnabled: saved['lessonRemindersEnabled'] ?? true,
        streakRemindersEnabled: saved['streakRemindersEnabled'] ?? true,
        achievementsEnabled: saved['achievementsEnabled'] ?? true,
        dailyAyahTime: saved['dailyAyahTime'] ?? '08:00',
        dailyHadithTime: saved['dailyHadithTime'] ?? '20:00',
      );
    }
  }

  void _saveSettings() {
    _storage.write('notificationSettings', {
      'dailyAyahEnabled': settings.value.dailyAyahEnabled,
      'dailyHadithEnabled': settings.value.dailyHadithEnabled,
      'prayerRemindersEnabled': settings.value.prayerRemindersEnabled,
      'lessonRemindersEnabled': settings.value.lessonRemindersEnabled,
      'streakRemindersEnabled': settings.value.streakRemindersEnabled,
      'achievementsEnabled': settings.value.achievementsEnabled,
      'dailyAyahTime': settings.value.dailyAyahTime,
      'dailyHadithTime': settings.value.dailyHadithTime,
    });
  }

  void updateSettings(NotificationSettings newSettings) {
    settings.value = newSettings;
    _saveSettings();
  }

  void toggleDailyAyah(bool value) {
    settings.value = settings.value.copyWith(dailyAyahEnabled: value);
    _saveSettings();
  }

  void toggleDailyHadith(bool value) {
    settings.value = settings.value.copyWith(dailyHadithEnabled: value);
    _saveSettings();
  }

  void togglePrayerReminders(bool value) {
    settings.value = settings.value.copyWith(prayerRemindersEnabled: value);
    _saveSettings();
  }

  void toggleLessonReminders(bool value) {
    settings.value = settings.value.copyWith(lessonRemindersEnabled: value);
    _saveSettings();
  }

  void toggleStreakReminders(bool value) {
    settings.value = settings.value.copyWith(streakRemindersEnabled: value);
    _saveSettings();
  }

  void toggleAchievements(bool value) {
    settings.value = settings.value.copyWith(achievementsEnabled: value);
    _saveSettings();
  }

  void updateDailyAyahTime(String time) {
    settings.value = settings.value.copyWith(dailyAyahTime: time);
    _saveSettings();
  }

  void updateDailyHadithTime(String time) {
    settings.value = settings.value.copyWith(dailyHadithTime: time);
    _saveSettings();
  }

  // ==================== NOTIFICATIONS ====================

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final n = notifications[index];
      notifications[index] = AppNotification(
        id: n.id,
        title: n.title,
        body: n.body,
        type: n.type,
        timestamp: n.timestamp,
        isRead: true,
        actionId: n.actionId,
      );
    }
  }

  void markAllAsRead() {
    for (int i = 0; i < notifications.length; i++) {
      final n = notifications[i];
      notifications[i] = AppNotification(
        id: n.id,
        title: n.title,
        body: n.body,
        type: n.type,
        timestamp: n.timestamp,
        isRead: true,
        actionId: n.actionId,
      );
    }
  }

  void deleteNotification(String id) {
    notifications.removeWhere((n) => n.id == id);
  }

  void clearAll() {
    notifications.clear();
  }

  void addNotification(AppNotification notification) {
    notifications.insert(0, notification);
  }

  void filterByType(NotificationType? type) {
    selectedFilter.value = type;
  }

  List<AppNotification> getFilteredNotifications() {
    if (selectedFilter.value == null) {
      return notifications.toList();
    }
    return notifications.where((n) => n.type == selectedFilter.value).toList();
  }


  int get unreadCount => notifications.where((n) => !n.isRead).length;

  int get totalCount => notifications.length;


  List<AppNotification> get unreadNotifications =>
      notifications.where((n) => !n.isRead).toList();

  List<AppNotification> get readNotifications =>
      notifications.where((n) => n.isRead).toList();


  List<AppNotification> getNotificationsByType(NotificationType type) {
    return notifications.where((n) => n.type == type).toList();
  }

  // ==================== SAMPLE NOTIFICATIONS ====================

  void addSampleNotification({
    required String title,
    required String body,
    required NotificationType type,
  }) {
    final notification = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      type: type,
      timestamp: DateTime.now(),
      isRead: false,
    );
    notifications.insert(0, notification);
  }

  // ==================== STATS ====================

  Map<String, int> getStats() {
    return {
      'total': notifications.length,
      'unread': unreadCount,
      'read': notifications.where((n) => n.isRead).length,
      'dailyAyah': getNotificationsByType(NotificationType.dailyAyah).length,
      'dailyHadith': getNotificationsByType(NotificationType.dailyHadith).length,
      'prayer': getNotificationsByType(NotificationType.prayerReminder).length,
      'lesson': getNotificationsByType(NotificationType.lessonReminder).length,
      'achievement': getNotificationsByType(NotificationType.achievement).length,
    };
  }
}