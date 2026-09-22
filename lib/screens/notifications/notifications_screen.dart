// lib/screens/notifications/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/models/notification_model.dart';
import 'package:noor_madrassa/services/notification_service.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationService _notificationService = Get.put(NotificationService());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Notifications',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 20),
                color: context.textColor,
              ),
            ),
            SizedBox(width: Responsive.padding(context, 8)),
            Obx(() {
              final count = _notificationService.unreadCount;
              if (count == 0) return const SizedBox.shrink();
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.padding(context, 8),
                  vertical: Responsive.padding(context, 2),
                ),
                decoration: BoxDecoration(
                  color: AppColors.emerald,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 11),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ],
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Mark All Read
          Obx(() => _notificationService.unreadCount > 0
              ? IconButton(
            icon: Icon(Icons.done_all, color: context.textColor),
            onPressed: () => _notificationService.markAllAsRead(),
          )
              : const SizedBox.shrink()),
          // Clear All
          IconButton(
            icon: Icon(Icons.delete_outline, color: context.textColor),
            onPressed: () => _showClearDialog(context, isDark),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          _buildFilterChips(context, isDark),

          const SizedBox(height: 8),

          // Notifications List
          Expanded(
            child: Obx(() {
              final notifications = _notificationService.getFilteredNotifications();
              if (notifications.isEmpty) {
                return _buildEmptyState(context, isDark);
              }
              return _buildNotificationsList(context, isDark, notifications);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context, bool isDark) {
    final types = <NotificationType?>[
      null,
      NotificationType.dailyAyah,
      NotificationType.dailyHadith,
      NotificationType.prayerReminder,
      NotificationType.lessonReminder,
      NotificationType.achievement,
    ];

    return Container(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
        itemCount: types.length,
        itemBuilder: (context, index) {
          final type = types[index];
          return Obx(() {
            final isSelected = _notificationService.selectedFilter.value == type;
            return GestureDetector(
              onTap: () => _notificationService.filterByType(type),
              child: Container(
                margin: EdgeInsets.only(right: Responsive.padding(context, 8)),
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.padding(context, 14),
                  vertical: Responsive.padding(context, 8),
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.emerald : context.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.emerald
                        : (isDark ? Colors.grey.shade700 : Colors.grey.shade200),
                  ),
                ),
                child: Text(
                  type?.label ?? 'All',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
                    color: isSelected ? Colors.white : context.textSecondaryColor,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildNotificationsList(
      BuildContext context,
      bool isDark,
      List<AppNotification> notifications,
      ) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return _buildNotificationCard(context, isDark, notifications[index]);
      },
    );
  }

  Widget _buildNotificationCard(BuildContext context, bool isDark, AppNotification notification) {
    final color = Color(int.parse(notification.type.color.replaceFirst('#', 'FF'), radix: 16));
    final isUnread = !notification.isRead;

    return GestureDetector(
      onTap: () {
        _notificationService.markAsRead(notification.id);
        _handleNotificationTap(context, notification);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Responsive.height(context, 10)),
        padding: EdgeInsets.all(Responsive.padding(context, 14)),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: isUnread
              ? Border.all(color: color.withOpacity(0.4), width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(isDark ? 0.1 : 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: Responsive.width(context, 44),
              height: Responsive.width(context, 44),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  notification.type.icon,
                  style: TextStyle(fontSize: Responsive.fontSize(context, 20)),
                ),
              ),
            ),
            SizedBox(width: Responsive.padding(context, 12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 14),
                            fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                            color: context.textColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.emerald,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: Responsive.height(context, 4)),
                  Text(
                    notification.body,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: context.textSecondaryColor,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Responsive.height(context, 6)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.padding(context, 6),
                          vertical: Responsive.padding(context, 2),
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          notification.type.label,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 9),
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        _formatTime(notification.timestamp),
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 10),
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Delete Button
            GestureDetector(
              onTap: () => _notificationService.deleteNotification(notification.id),
              child: Icon(
                Icons.close,
                size: Responsive.width(context, 16),
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Responsive.padding(context, 32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Responsive.width(context, 100),
              height: Responsive.width(context, 100),
              decoration: BoxDecoration(
                color: AppColors.emerald.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_off,
                size: Responsive.width(context, 50),
                color: AppColors.emerald,
              ),
            ),
            SizedBox(height: Responsive.height(context, 20)),
            Text(
              'No Notifications',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 18),
                fontWeight: FontWeight.bold,
                color: context.textColor,
              ),
            ),
            SizedBox(height: Responsive.height(context, 8)),
            Text(
              'You\'re all caught up!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNotificationTap(BuildContext context, AppNotification notification) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening: ${notification.title}')),
    );
  }

  void _showClearDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Clear All?',
            style: TextStyle(color: context.textColor),
          ),
          content: Text(
            'Are you sure you want to delete all notifications?',
            style: TextStyle(color: context.textSecondaryColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: context.textSecondaryColor),
              ),
            ),
            TextButton(
              onPressed: () {
                _notificationService.clearAll();
                Navigator.pop(context);
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }
}