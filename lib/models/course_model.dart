
// lib/models/course_model.dart
class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final int totalLessons;
  final int completedLessons;
  final String category;
  final double progress;
  final String imageUrl;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.totalLessons,
    required this.completedLessons,
    required this.category,
    required this.progress,
    required this.imageUrl,
  });
}