// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/app_theme.dart';
import 'services/theme_service.dart';
import 'services/audio_service.dart';
import 'screens/splash_screen.dart';
import 'services/search_service.dart';
import 'services/bookmark_service.dart';
import 'services/dua_service.dart';
import 'services/achievement_service.dart';
import 'services/font_size_service.dart';
import 'services/language_service.dart';
import 'services/notification_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();


  Get.put(ThemeService());
  Get.put(AudioService());
  Get.put(SearchService());
  Get.put(BookmarkService());
  runApp(const NoorMadrassaApp());
  Get.put(DuaService());
  Get.put(AchievementService());
  Get.put(FontSizeService());
  Get.put(LanguageService());
  Get.put(NotificationService());
}

class NoorMadrassaApp extends StatelessWidget {
  const NoorMadrassaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();

    return GetMaterialApp(
      title: 'Noor Madrassa',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeService.themeMode,

      home: const SplashScreen(),
    );
  }
}