// lib/data/user_data.dart
import '../models/user_model.dart';
import 'package:flutter/material.dart';

User dummyUser = User(
  id: '1',
  name: 'Ahmed Khan',
  email: 'ahmed@example.com',
  avatarColor: '#0F5C4D',
  quranReadingStreak: 15,
  lessonsCompleted: 22,
  totalLessons: 30,
  savedItems: 45,
  certificates: 3,
  overallProgress: 0.73,
);

List<Map<String, dynamic>> dummyActivities = [
  {
    'icon': '📖',
    'title': 'Completed Surah Al-Kahf',
    'subtitle': '2 hours ago',
    'type': 'quran',
  },
  {
    'icon': '📚',
    'title': 'Saved Hadith: Bukhari 1',
    'subtitle': '5 hours ago',
    'type': 'hadith',
  },
  {
    'icon': '🏆',
    'title': 'Earned \'Quran Reader\' Badge',
    'subtitle': '1 day ago',
    'type': 'achievement',
  },
  {
    'icon': '📘',
    'title': 'Read Chapter 3 of Tafsir Ibn Kathir',
    'subtitle': '2 days ago',
    'type': 'book',
  },
  {
    'icon': '🎯',
    'title': 'Completed Lesson: Tajweed Rules',
    'subtitle': '3 days ago',
    'type': 'course',
  },
];

List<Map<String, dynamic>> dummySettings = [
  {
    'icon': Icons.language,
    'title': 'Language',
    'subtitle': 'English',
    'type': 'language',
  },
  {
    'icon': Icons.brightness_6,
    'title': 'Theme',
    'subtitle': 'System Default',
    'type': 'theme',
  },
  {
    'icon': Icons.text_fields,
    'title': 'Font Size',
    'subtitle': 'Medium',
    'type': 'font_size',
  },
  {
    'icon': Icons.volume_up,
    'title': 'Audio Settings',
    'subtitle': 'Reciter: Default',
    'type': 'audio',
  },
  {
    'icon': Icons.translate,
    'title': 'Translation Language',
    'subtitle': 'English',
    'type': 'translation',
  },
  {
    'icon': Icons.notifications,
    'title': 'Notifications',
    'subtitle': 'On',
    'type': 'notifications',
  },
  {
    'icon': Icons.cloud_download,
    'title': 'Downloaded Content',
    'subtitle': '12 items',
    'type': 'downloads',
  },
  {
    'icon': Icons.info_outline,
    'title': 'About',
    'subtitle': 'Noor Madrassa v0.1.0',
    'type': 'about',
  },
];