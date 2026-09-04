// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:noor_madrassa/app/app_theme.dart';
import 'package:noor_madrassa/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const NoorMadrassaApp());
}

class NoorMadrassaApp extends StatelessWidget {
  const NoorMadrassaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noor Madrassa',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}