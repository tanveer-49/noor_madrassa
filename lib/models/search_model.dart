// lib/models/search_model.dart
class SearchResult {
  final String id;
  final String title;
  final String subtitle;
  final String content;
  final SearchContentType type;
  final String icon;
  final String? reference;
  final String? arabicText;

  SearchResult({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.type,
    required this.icon,
    this.reference,
    this.arabicText,
  });
}

enum SearchContentType {
  quran,
  hadith,
  book,
  dua,
  course,
  lesson,
}

extension SearchContentTypeExtension on SearchContentType {
  String get label {
    switch (this) {
      case SearchContentType.quran:
        return 'Qur\'an';
      case SearchContentType.hadith:
        return 'Hadith';
      case SearchContentType.book:
        return 'Book';
      case SearchContentType.dua:
        return 'Dua';
      case SearchContentType.course:
        return 'Course';
      case SearchContentType.lesson:
        return 'Lesson';
    }
  }

  String get color {
    switch (this) {
      case SearchContentType.quran:
        return '#0F5C4D';
      case SearchContentType.hadith:
        return '#187A64';
      case SearchContentType.book:
        return '#C7A44A';
      case SearchContentType.dua:
        return '#8B6B3D';
      case SearchContentType.course:
        return '#4A5A55';
      case SearchContentType.lesson:
        return '#2E7D32';
    }
  }
}

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