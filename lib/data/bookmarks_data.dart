// lib/data/bookmarks_data.dart
import '../models/bookmark_model.dart';

List<Bookmark> dummyBookmarks = [
  Bookmark(
    id: 'bm1',
    title: 'Al-Kahf: Verse 23',
    subtitle: 'Surah 18 • Qur\'an',
    content: 'And never say about anything, "I will do that tomorrow,"',
    type: BookmarkType.quran,
    icon: '📖',
    reference: 'Al-Kahf: 23',
    arabicText: 'وَلَا تَقُولَنَّ لِشَيْءٍ إِنِّي فَاعِلٌ ذَٰلِكَ غَدًا',
    savedAt: DateTime.now().subtract(const Duration(hours: 2)),
    folder: 'Qur\'an',
  ),
  Bookmark(
    id: 'bm2',
    title: 'Actions are judged by intentions',
    subtitle: 'Sahih Bukhari • Hadith',
    content: 'Actions are judged by intentions, and every person will get what they intended.',
    type: BookmarkType.hadith,
    icon: '📚',
    reference: 'Bukhari 1',
    arabicText: 'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ',
    savedAt: DateTime.now().subtract(const Duration(days: 1)),
    folder: 'Hadith',
  ),
  Bookmark(
    id: 'bm3',
    title: 'Tafsir Ibn Kathir - Al-Fatihah',
    subtitle: 'Imam Ibn Kathir • Tafsir',
    content: 'One of the most renowned and widely accepted commentaries on the Quran.',
    type: BookmarkType.book,
    icon: '📘',
    reference: 'Tafsir Ibn Kathir',
    savedAt: DateTime.now().subtract(const Duration(days: 2)),
    folder: 'Books',
  ),
  Bookmark(
    id: 'bm4',
    title: 'Morning Dua',
    subtitle: 'Daily Dua • Morning',
    content: 'O Allah, by You we enter the morning and by You we enter the evening.',
    type: BookmarkType.dua,
    icon: '🤲',
    reference: 'Morning Azkar',
    arabicText: 'اللَّهُمَّ بِكَ أَصْبَحْنَا',
    savedAt: DateTime.now().subtract(const Duration(days: 3)),
    folder: 'Duas',
  ),
  Bookmark(
    id: 'bm5',
    title: 'Prayer is the pillar of religion',
    subtitle: 'Sahih Bukhari • Hadith',
    content: 'Prayer is the pillar of religion. Whoever establishes it has established the religion.',
    type: BookmarkType.hadith,
    icon: '📚',
    reference: 'Bukhari 567',
    arabicText: 'الصَّلاَةُ عِمَادُ الدِّينِ',
    savedAt: DateTime.now().subtract(const Duration(days: 4)),
    folder: 'Hadith',
  ),
];

// Get bookmarks by type
List<Bookmark> getBookmarksByType(BookmarkType? type) {
  if (type == null) return dummyBookmarks;
  return dummyBookmarks.where((b) => b.type == type).toList();
}

// Get bookmarks by folder
List<Bookmark> getBookmarksByFolder(String folder) {
  if (folder == 'All') return dummyBookmarks;
  return dummyBookmarks.where((b) => b.folder == folder).toList();
}

// Get all folders
List<String> getBookmarkFolders() {
  return ['All', 'Qur\'an', 'Hadith', 'Books', 'Duas'];
}