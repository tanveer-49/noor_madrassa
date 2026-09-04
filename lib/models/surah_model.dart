// lib/models/surah_model.dart
class Surah {
  final int id;
  final String nameArabic;
  final String nameEnglish;
  final int versesCount;
  final String placeOfRevelation;
  final String translation;

  Surah({
    required this.id,
    required this.nameArabic,
    required this.nameEnglish,
    required this.versesCount,
    required this.placeOfRevelation,
    required this.translation,
  });
}
