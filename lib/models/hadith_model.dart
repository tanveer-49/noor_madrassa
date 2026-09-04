
// lib/models/hadith_model.dart
class Hadith {
  final String id;
  final String arabicText;
  final String englishTranslation;
  final String reference;
  final String bookName;
  final String chapter;
  final String grade;

  Hadith({
    required this.id,
    required this.arabicText,
    required this.englishTranslation,
    required this.reference,
    required this.bookName,
    required this.chapter,
    required this.grade,
  });
}
