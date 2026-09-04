// lib/models/hadith_model.dart
class HadithCollection {
  final String id;
  final String name;
  final String nameArabic;
  final String description;
  final String author;
  final int totalHadith;
  final String icon;
  final String color;

  HadithCollection({
    required this.id,
    required this.name,
    required this.nameArabic,
    required this.description,
    required this.author,
    required this.totalHadith,
    required this.icon,
    required this.color,
  });
}

class Hadith {
  final String id;
  final String collectionId;
  final String chapter;
  final String chapterArabic;
  final String hadithNumber;
  final String arabicText;
  final String englishTranslation;
  final String reference;
  final String grade;
  final bool isBookmarked;

  Hadith({
    required this.id,
    required this.collectionId,
    required this.chapter,
    required this.chapterArabic,
    required this.hadithNumber,
    required this.arabicText,
    required this.englishTranslation,
    required this.reference,
    required this.grade,
    this.isBookmarked = false,
  });
}