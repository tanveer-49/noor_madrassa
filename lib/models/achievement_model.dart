// lib/models/achievement_model.dart

class AchievementBadge {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String color;
  final BadgeType type;
  final bool isEarned;
  final DateTime? earnedAt;
  final double progress;

  AchievementBadge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.type,
    this.isEarned = false,
    this.earnedAt,
    this.progress = 0.0,
  });
}

enum BadgeType {
  quran,
  hadith,
  course,
  streak,
  bookmark,
  special,
}

extension BadgeTypeExtension on BadgeType {
  String get label {
    switch (this) {
      case BadgeType.quran:
        return 'Qur\'an';
      case BadgeType.hadith:
        return 'Hadith';
      case BadgeType.course:
        return 'Course';
      case BadgeType.streak:
        return 'Streak';
      case BadgeType.bookmark:
        return 'Bookmark';
      case BadgeType.special:
        return 'Special';
    }
  }
}

class Certificate {
  final String id;
  final String title;
  final String description;
  final String courseName;
  final String instructor;
  final DateTime issuedAt;
  final String certificateNumber;
  final String icon;
  final String color;

  Certificate({
    required this.id,
    required this.title,
    required this.description,
    required this.courseName,
    required this.instructor,
    required this.issuedAt,
    required this.certificateNumber,
    required this.icon,
    required this.color,
  });
}