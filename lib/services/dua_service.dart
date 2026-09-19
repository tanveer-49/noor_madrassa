// lib/services/dua_service.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/dua_model.dart';
import '../data/duas_data.dart';

class DuaService extends GetxService {
  final GetStorage _storage = GetStorage();

  final RxList<Dua> allDuas = <Dua>[].obs;
  final Rx<DuaCategory?> selectedCategory = Rx<DuaCategory?>(null);
  final RxList<String> favoriteIds = <String>[].obs;
  final RxBool showFavoritesOnly = false.obs;

  @override
  void onInit() {
    super.onInit();
    allDuas.value = dummyDuas;
    _loadFavorites();
  }

  void _loadFavorites() {
    final saved = _storage.read<List>('favoriteDuas');
    if (saved != null) {
      favoriteIds.value = saved.cast<String>();
      // Update favorite status
      for (var dua in allDuas) {
        if (favoriteIds.contains(dua.id)) {
          allDuas[allDuas.indexOf(dua)] = Dua(
            id: dua.id,
            title: dua.title,
            titleArabic: dua.titleArabic,
            arabicText: dua.arabicText,
            transliteration: dua.transliteration,
            translation: dua.translation,
            reference: dua.reference,
            category: dua.category,
            isFavorite: true,
          );
        }
      }
    }
  }

  void _saveFavorites() {
    _storage.write('favoriteDuas', favoriteIds.toList());
  }

  void toggleFavorite(String duaId) {
    final index = allDuas.indexWhere((d) => d.id == duaId);
    if (index == -1) return;

    final dua = allDuas[index];
    final newFavoriteStatus = !dua.isFavorite;

    // Update in list
    allDuas[index] = Dua(
      id: dua.id,
      title: dua.title,
      titleArabic: dua.titleArabic,
      arabicText: dua.arabicText,
      transliteration: dua.transliteration,
      translation: dua.translation,
      reference: dua.reference,
      category: dua.category,
      isFavorite: newFavoriteStatus,
    );

    // Update favorites list
    if (newFavoriteStatus) {
      if (!favoriteIds.contains(duaId)) {
        favoriteIds.add(duaId);
      }
    } else {
      favoriteIds.remove(duaId);
    }

    _saveFavorites();
  }

  void filterByCategory(DuaCategory? category) {
    selectedCategory.value = category;
  }

  void toggleFavoritesOnly() {
    showFavoritesOnly.value = !showFavoritesOnly.value;
  }

  List<Dua> getFilteredDuas() {
    var filtered = allDuas.toList();

    if (showFavoritesOnly.value) {
      filtered = filtered.where((d) => d.isFavorite).toList();
    }

    if (selectedCategory.value != null) {
      filtered = filtered.where((d) => d.category == selectedCategory.value).toList();
    }

    return filtered;
  }

  bool isFavorite(String duaId) {
    return favoriteIds.contains(duaId);
  }
}