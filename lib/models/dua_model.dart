// lib/models/dua_model.dart
class Dua {
  final String id;
  final String title;
  final String titleArabic;
  final String arabicText;
  final String transliteration;
  final String translation;
  final String reference;
  final DuaCategory category;
  final bool isFavorite;

  Dua({
    required this.id,
    required this.title,
    required this.titleArabic,
    required this.arabicText,
    required this.transliteration,
    required this.translation,
    required this.reference,
    required this.category,
    this.isFavorite = false,
  });
}

enum DuaCategory {
  morning,
  evening,
  prayer,
  travel,
  protection,
  forgiveness,
  gratitude,
  daily,
}

extension DuaCategoryExtension on DuaCategory {
  String get label {
    switch (this) {
      case DuaCategory.morning:
        return 'Morning';
      case DuaCategory.evening:
        return 'Evening';
      case DuaCategory.prayer:
        return 'Prayer';
      case DuaCategory.travel:
        return 'Travel';
      case DuaCategory.protection:
        return 'Protection';
      case DuaCategory.forgiveness:
        return 'Forgiveness';
      case DuaCategory.gratitude:
        return 'Gratitude';
      case DuaCategory.daily:
        return 'Daily';
    }
  }

  String get icon {
    switch (this) {
      case DuaCategory.morning:
        return '🌅';
      case DuaCategory.evening:
        return '🌙';
      case DuaCategory.prayer:
        return '🕌';
      case DuaCategory.travel:
        return '✈️';
      case DuaCategory.protection:
        return '🛡️';
      case DuaCategory.forgiveness:
        return '🤲';
      case DuaCategory.gratitude:
        return '❤️';
      case DuaCategory.daily:
        return '📿';
    }
  }

  String get color {
    switch (this) {
      case DuaCategory.morning:
        return '#C7A44A';
      case DuaCategory.evening:
        return '#0F5C4D';
      case DuaCategory.prayer:
        return '#187A64';
      case DuaCategory.travel:
        return '#8B6B3D';
      case DuaCategory.protection:
        return '#4A5A55';
      case DuaCategory.forgiveness:
        return '#2E7D32';
      case DuaCategory.gratitude:
        return '#B8860B';
      case DuaCategory.daily:
        return '#0B1F1A';
    }
  }
}