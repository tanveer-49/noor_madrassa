// lib/services/search_service.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/search_model.dart';
import '../data/search_data.dart';

class SearchService extends GetxService {
  final GetStorage _storage = GetStorage();

  final RxString currentQuery = ''.obs;
  final RxList<SearchResult> results = <SearchResult>[].obs;
  final Rx<SearchContentType?> selectedType = Rx<SearchContentType?>(null);
  final RxList<String> recentSearches = <String>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRecentSearches();
  }

  void _loadRecentSearches() {
    final saved = _storage.read<List>('recentSearches');
    if (saved != null) {
      recentSearches.value = saved.cast<String>();
    } else {
      recentSearches.value = [];
    }
  }

  void search(String query) {
    currentQuery.value = query;

    if (query.isEmpty) {
      results.value = [];
      return;
    }

    isLoading.value = true;

    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (selectedType.value == null) {
        results.value = searchAll(query);
      } else {
        results.value = searchByType(query, selectedType.value);
      }
      isLoading.value = false;

      // Save to recent searches
      _addToRecentSearches(query);
    });
  }

  void filterByType(SearchContentType? type) {
    selectedType.value = type;
    if (currentQuery.value.isNotEmpty) {
      search(currentQuery.value);
    }
  }

  void _addToRecentSearches(String query) {
    if (query.isEmpty) return;

    final list = recentSearches.toList();
    list.remove(query);
    list.insert(0, query);

    // Keep only last 10
    if (list.length > 10) {
      list.removeRange(10, list.length);
    }

    recentSearches.value = list;
    _storage.write('recentSearches', list);
  }

  void clearRecentSearches() {
    recentSearches.value = [];
    _storage.remove('recentSearches');
  }

  void removeRecentSearch(String query) {
    final list = recentSearches.toList();
    list.remove(query);
    recentSearches.value = list;
    _storage.write('recentSearches', list);
  }

  void clearResults() {
    currentQuery.value = '';
    results.value = [];
    selectedType.value = null;
  }
}