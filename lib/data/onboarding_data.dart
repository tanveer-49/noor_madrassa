// lib/data/onboarding_data.dart
import 'package:flutter/material.dart';
import '../models/onboarding_model.dart';

List<OnboardingItem> onboardingData = [
  OnboardingItem(
    title: 'Qur\'an & Translation',
    description: 'Read the Holy Qur\'an with Arabic text, translations, and tafsir. A guidance for those conscious of Allah.',
    icon: Icons.menu_book,
    tagline: 'Divine Guidance',
  ),
  OnboardingItem(
    title: 'Hadith & Islamic Library',
    description: 'Access authentic Hadith collections like Sahih Bukhari, Muslim, and thousands of Islamic books.',
    icon: Icons.library_books,
    tagline: 'Prophetic Wisdom',
  ),
  OnboardingItem(
    title: 'Madrassa Learning',
    description: 'Track your progress, complete lessons, earn badges, and grow in your Islamic knowledge journey.',
    icon: Icons.school,
    tagline: 'Knowledge Journey',
  ),
];