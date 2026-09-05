// lib/models/user_model.dart
class User {
  final String id;
  final String name;
  final String email;
  final String avatarColor;
  final int quranReadingStreak;
  final int lessonsCompleted;
  final int totalLessons;
  final int savedItems;
  final int certificates;
  final double overallProgress;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarColor,
    this.quranReadingStreak = 0,
    this.lessonsCompleted = 0,
    this.totalLessons = 30,
    this.savedItems = 0,
    this.certificates = 0,
    this.overallProgress = 0.0,
  });
}