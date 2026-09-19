// lib/models/bookmark_model.dart
class Bookmark {
  final String id;
  final String title;
  final String subtitle;
  final String content;
  final BookmarkType type;
  final String icon;
  final String? reference;
  final String? arabicText;
  final DateTime savedAt;
  final String folder;

  Bookmark({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.type,
    required this.icon,
    this.reference,
    this.arabicText,
    required this.savedAt,
    this.folder = 'General',
  });
}

enum BookmarkType {
  quran,
  hadith,
  book,
  dua,
}

extension BookmarkTypeExtension on BookmarkType {
  String get label {
    switch (this) {
      case BookmarkType.quran:
        return 'Qur\'an';
      case BookmarkType.hadith:
        return 'Hadith';
      case BookmarkType.book:
        return 'Book';
      case BookmarkType.dua:
        return 'Dua';
    }
  }

  String get icon {
    switch (this) {
      case BookmarkType.quran:
        return '📖';
      case BookmarkType.hadith:
        return '📚';
      case BookmarkType.book:
        return '📘';
      case BookmarkType.dua:
        return '🤲';
    }
  }
}