// lib/models/surah_model.dart
class Surah {
  final int id;
  final String nameArabic;
  final String nameEnglish;
  final String translation;
  final int versesCount;
  final String placeOfRevelation;
  final bool isBookmarked;

  Surah({
    required this.id,
    required this.nameArabic,
    required this.nameEnglish,
    required this.translation,
    required this.versesCount,
    required this.placeOfRevelation,
    this.isBookmarked = false,
  });
}