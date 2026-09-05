// lib/services/theme_service.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../app/app_theme.dart';

class ThemeService extends GetxService {
  final GetStorage _storage = GetStorage();
  final RxString currentTheme = 'system'.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved theme
    String savedTheme = _storage.read('theme') ?? 'system';
    currentTheme.value = savedTheme;
    _applyTheme(savedTheme);
  }

  ThemeMode get themeMode {
    switch (currentTheme.value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void changeTheme(String themeMode) {
    currentTheme.value = themeMode;
    _storage.write('theme', themeMode);
    _applyTheme(themeMode);
    Get.forceAppUpdate();
  }

  void _applyTheme(String themeMode) {
    switch (themeMode) {
      case 'light':
        Get.changeTheme(AppTheme.lightTheme);
        break;
      case 'dark':
        Get.changeTheme(AppTheme.darkTheme);
        break;
      default:
        Get.changeTheme(ThemeMode.system == ThemeMode.dark
            ? AppTheme.darkTheme
            : AppTheme.lightTheme);
    }
  }

  String getCurrentThemeName() {
    switch (currentTheme.value) {
      case 'light':
        return 'Light Mode';
      case 'dark':
        return 'Dark Mode';
      default:
        return 'System Default';
    }
  }

  List<Map<String, String>> getAvailableThemes() {
    return [
      {'code': 'light', 'name': 'Light Mode'},
      {'code': 'dark', 'name': 'Dark Mode'},
      {'code': 'system', 'name': 'System Default'},
    ];
  }
}