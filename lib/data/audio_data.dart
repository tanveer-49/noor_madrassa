// lib/data/audio_data.dart
import '../models/audio_model.dart';

List<AudioTrack> dummyAudioTracks = [
  AudioTrack(
    id: '1',
    title: 'Al-Fatihah',
    titleArabic: 'الفاتحة',
    reciter: 'Mishary Rashid Alafasy',
    reciterArabic: 'مشاري راشد العفاسي',
    surahName: 'Al-Fatihah',
    surahNumber: 1,
    audioUrl: 'https://example.com/audio/1.mp3',
    duration: const Duration(minutes: 1, seconds: 30),
  ),
  AudioTrack(
    id: '2',
    title: 'Al-Kahf',
    titleArabic: 'الكهف',
    reciter: 'Mishary Rashid Alafasy',
    reciterArabic: 'مشاري راشد العفاسي',
    surahName: 'Al-Kahf',
    surahNumber: 18,
    audioUrl: 'https://example.com/audio/18.mp3',
    duration: const Duration(minutes: 35, seconds: 45),
  ),
  AudioTrack(
    id: '3',
    title: 'Yasin',
    titleArabic: 'يس',
    reciter: 'Abdul Basit',
    reciterArabic: 'عبد الباسط',
    surahName: 'Yasin',
    surahNumber: 36,
    audioUrl: 'https://example.com/audio/36.mp3',
    duration: const Duration(minutes: 20, seconds: 15),
  ),
  AudioTrack(
    id: '4',
    title: 'Ar-Rahman',
    titleArabic: 'الرحمن',
    reciter: 'Mishary Rashid Alafasy',
    reciterArabic: 'مشاري راشد العفاسي',
    surahName: 'Ar-Rahman',
    surahNumber: 55,
    audioUrl: 'https://example.com/audio/55.mp3',
    duration: const Duration(minutes: 12, seconds: 30),
  ),
  AudioTrack(
    id: '5',
    title: 'Al-Mulk',
    titleArabic: 'الملك',
    reciter: 'Abdul Basit',
    reciterArabic: 'عبد الباسط',
    surahName: 'Al-Mulk',
    surahNumber: 67,
    audioUrl: 'https://example.com/audio/67.mp3',
    duration: const Duration(minutes: 8, seconds: 45),
  ),
];

List<String> dummyReciters = [
  'Mishary Rashid Alafasy',
  'Abdul Basit',
  'Saad Al-Ghamdi',
  'Maher Al-Muaiqly',
  'Saud Al-Shuraim',
];