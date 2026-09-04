// lib/models/verse_model.dart
class Verse {
  final int id;
  final int surahId;
  final int verseNumber;
  final String arabicText;
  final String translation;
  final String transliteration;
  final bool isBookmarked;

  Verse({
    required this.id,
    required this.surahId,
    required this.verseNumber,
    required this.arabicText,
    required this.translation,
    required this.transliteration,
    this.isBookmarked = false,
  });
}