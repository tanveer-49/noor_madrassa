// lib/services/language_service.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageService extends GetxService {
  final GetStorage _storage = GetStorage();
  final RxString currentLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    String savedLanguage = _storage.read('language') ?? 'en';
    currentLanguage.value = savedLanguage;
  }

  void changeLanguage(String code) {
    currentLanguage.value = code;
    _storage.write('language', code);
    Get.forceAppUpdate();
  }

  String getCurrentLanguageName() {
    switch (currentLanguage.value) {
      case 'ur':
        return 'اردو';
      case 'ar':
        return 'العربية';
      default:
        return 'English';
    }
  }

  List<Map<String, String>> getAvailableLanguages() {
    return [
      {'code': 'en', 'name': 'English', 'native': 'English'},
      {'code': 'ur', 'name': 'Urdu', 'native': 'اردو'},
      {'code': 'ar', 'name': 'Arabic', 'native': 'العربية'},
    ];
  }

  // Translation map (basic)
  String translate(String key) {
    final translations = {
      'en': {
        'settings': 'Settings',
        'language': 'Language',
        'theme': 'Theme',
        'font_size': 'Font Size',
        'notifications': 'Notifications',
        'about': 'About',
      },
      'ur': {
        'settings': 'ترتیبات',
        'language': 'زبان',
        'theme': 'تھیم',
        'font_size': 'فونٹ سائز',
        'notifications': 'اطلاعات',
        'about': 'تعارف',
      },
      'ar': {
        'settings': 'الإعدادات',
        'language': 'اللغة',
        'theme': 'المظهر',
        'font_size': 'حجم الخط',
        'notifications': 'الإشعارات',
        'about': 'حول',
      },
    };
    return translations[currentLanguage.value]?[key] ?? key;
  }
}

// Extension for easy translation
extension TranslateExtension on String {
  String get tr => Get.find<LanguageService>().translate(this);
}