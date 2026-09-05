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

  // Factory method to create from JSON (for future use)
  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'] ?? '',
      bookId: json['bookId'] ?? '',
      title: json['title'] ?? '',
      titleArabic: json['titleArabic'] ?? '',
      chapterNumber: json['chapterNumber'] ?? 0,
      content: json['content'] ?? '',
      isRead: json['isRead'] ?? false,
    );
  }

  // Convert to JSON (for future use)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookId': bookId,
      'title': title,
      'titleArabic': titleArabic,
      'chapterNumber': chapterNumber,
      'content': content,
      'isRead': isRead,
    };
  }
}