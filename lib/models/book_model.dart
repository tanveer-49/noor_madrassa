// lib/models/book_model.dart
import 'chapter_model.dart';

class Book {
  final String id;
  final String title;
  final String titleArabic;
  final String author;
  final String authorArabic;
  final String category;
  final String description;
  final int pages;
  final int currentPage;
  final double progress;
  final String coverColor;
  final String icon;
  final bool isBookmarked;
  final List<String> chapters;

  Book({
    required this.id,
    required this.title,
    required this.titleArabic,
    required this.author,
    required this.authorArabic,
    required this.category,
    required this.description,
    required this.pages,
    this.currentPage = 0,
    this.progress = 0.0,
    required this.coverColor,
    required this.icon,
    this.isBookmarked = false,
    this.chapters = const [],
  });
}

// lib/models/chapter_model.dart
class Chapter {
  final String id;
  final String bookId;
  final String title;
  final String titleArabic;
  final int chapterNumber;
  final String content;
  final bool isRead;

  Chapter({
    required this.id,
    required this.bookId,
    required this.title,
    required this.titleArabic,
    required this.chapterNumber,
    required this.content,
    this.isRead = false,
  });
}