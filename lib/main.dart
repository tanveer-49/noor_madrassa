// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/app_theme.dart';
import 'services/theme_service.dart';
import 'services/audio_service.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();


  Get.put(ThemeService());
  Get.put(AudioService());

  runApp(const NoorMadrassaApp());
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