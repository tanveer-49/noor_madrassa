// lib/models/audio_model.dart
class AudioTrack {
  final String id;
  final String title;
  final String titleArabic;
  final String reciter;
  final String reciterArabic;
  final String surahName;
  final int surahNumber;
  final String audioUrl;
  final Duration duration;
  final bool isDownloaded;

  AudioTrack({
    required this.id,
    required this.title,
    required this.titleArabic,
    required this.reciter,
    required this.reciterArabic,
    required this.surahName,
    required this.surahNumber,
    required this.audioUrl,
    required this.duration,
    this.isDownloaded = false,
  });
}