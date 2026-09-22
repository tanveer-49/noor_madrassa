// lib/services/font_size_service.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FontSizeService extends GetxService {
  final GetStorage _storage = GetStorage();
  final RxString currentFontSize = 'medium'.obs;

  @override
  void onInit() {
    super.onInit();
    String savedFontSize = _storage.read('fontSize') ?? 'medium';
    currentFontSize.value = savedFontSize;
  }

  double get fontSize {
    switch (currentFontSize.value) {
      case 'small':
        return 14.0;
      case 'medium':
        return 16.0;
      case 'large':
        return 18.0;
      case 'extra_large':
        return 22.0;
      default:
        return 16.0;
    }
  }

  double get quranFontSize {
    switch (currentFontSize.value) {
      case 'small':
        return 18.0;
      case 'medium':
        return 22.0;
      case 'large':
        return 28.0;
      case 'extra_large':
        return 34.0;
      default:
        return 22.0;
    }
  }

  void changeFontSize(String size) {
    currentFontSize.value = size;
    _storage.write('fontSize', size);
    Get.forceAppUpdate();
  }

  String getCurrentFontSizeName() {
    switch (currentFontSize.value) {
      case 'small':
        return 'Small';
      case 'medium':
        return 'Medium';
      case 'large':
        return 'Large';
      case 'extra_large':
        return 'Extra Large';
      default:
        return 'Medium';
    }
  }

  List<Map<String, String>> getAvailableFontSizes() {
    return [
      {'code': 'small', 'name': 'Small', 'size': '14px'},
      {'code': 'medium', 'name': 'Medium', 'size': '16px'},
      {'code': 'large', 'name': 'Large', 'size': '18px'},
      {'code': 'extra_large', 'name': 'Extra Large', 'size': '22px'},
    ];
  }
}