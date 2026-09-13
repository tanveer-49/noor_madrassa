// lib/models/course_model.dart
class Course {
  final String id;
  final String title;
  final String titleArabic;
  final String description;
  final String instructor;
  final String instructorArabic;
  final String category;
  final String level;
  final int totalLessons;
  final int completedLessons;
  final double progress;
  final String icon;
  final String color;
  final bool isEnrolled;
  final List<Module> modules;

  Course({
    required this.id,
    required this.title,
    required this.titleArabic,
    required this.description,
    required this.instructor,
    required this.instructorArabic,
    required this.category,
    required this.level,
    required this.totalLessons,
    required this.completedLessons,
    required this.progress,
    required this.icon,
    required this.color,
    this.isEnrolled = false,
    this.modules = const [],
  });
}

class Module {
  final String id;
  final String courseId;
  final String title;
  final String titleArabic;
  final int moduleNumber;
  final int totalLessons;
  final int completedLessons;
  final List<Lesson> lessons;

  Module({
    required this.id,
    required this.courseId,
    required this.title,
    required this.titleArabic,
    required this.moduleNumber,
    required this.totalLessons,
    required this.completedLessons,
    this.lessons = const [],
  });
}

class Lesson {
  final String id;
  final String moduleId;
  final String title;
  final String titleArabic;
  final int lessonNumber;
  final Duration duration;
  final bool isCompleted;
  final bool isLocked;
  final String content;
  final String teacher;
  final String teacherArabic;
  final List<QuizQuestion> quiz;

  Lesson({
    required this.id,
    required this.moduleId,
    required this.title,
    required this.titleArabic,
    required this.lessonNumber,
    required this.duration,
    this.isCompleted = false,
    this.isLocked = false,
    required this.content,
    required this.teacher,
    required this.teacherArabic,
    this.quiz = const [],
  });
}

class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}