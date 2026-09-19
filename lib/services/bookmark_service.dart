// lib/services/bookmark_service.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/bookmark_model.dart';
import '../data/bookmarks_data.dart';

class BookmarkService extends GetxService {
  final GetStorage _storage = GetStorage();

  final RxList<Bookmark> bookmarks = <Bookmark>[].obs;
  final Rx<BookmarkType?> selectedType = Rx<BookmarkType?>(null);
  final RxString selectedFolder = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadBookmarks();
  }

  void _loadBookmarks() {
    // For demo, use dummy data
    // In production, load from storage
    bookmarks.value = dummyBookmarks;
  }

  void addBookmark(Bookmark bookmark) {
    if (!bookmarks.any((b) => b.id == bookmark.id)) {
      bookmarks.add(bookmark);
      _saveBookmarks();
    }
  }

  void removeBookmark(String id) {
    bookmarks.removeWhere((b) => b.id == id);
    _saveBookmarks();
  }

  void toggleBookmark(Bookmark bookmark) {
    if (isBookmarked(bookmark.id)) {
      removeBookmark(bookmark.id);
    } else {
      addBookmark(bookmark);
    }
  }

  bool isBookmarked(String id) {
    return bookmarks.any((b) => b.id == id);
  }

  void filterByType(BookmarkType? type) {
    selectedType.value = type;
  }

  void filterByFolder(String folder) {
    selectedFolder.value = folder;
  }

  List<Bookmark> getFilteredBookmarks() {
    var filtered = bookmarks.toList();

    if (selectedType.value != null) {
      filtered = filtered.where((b) => b.type == selectedType.value).toList();
    }

    if (selectedFolder.value != 'All') {
      filtered = filtered.where((b) => b.folder == selectedFolder.value).toList();
    }

    return filtered;
  }

  void _saveBookmarks() {
    // For production: save to storage
    // _storage.write('bookmarks', bookmarks.map((b) => b.toJson()).toList());
  }

  List<String> getFolders() {
    return getBookmarkFolders();
  }
}