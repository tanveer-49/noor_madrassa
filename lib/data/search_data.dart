// lib/data/search_data.dart
import '../models/search_model.dart';

List<String> recentSearches = [
  'Al-Kahf',
  'Sahih Bukhari',
  'Tafsir Ibn Kathir',
  'Morning Dua',
  'Tajweed',
  'Seerah',
];

List<String> suggestedTopics = [
  'Qur\'an',
  'Hadith',
  'Fiqh',
  'Seerah',
  'Tafsir',
  'Aqeedah',
  'Akhlaq',
  'Duas',
  'Tajweed',
  'Islamic History',
];

List<SearchResult> allSearchResults = [
  // Qur'an Results
  SearchResult(
    id: 'q1',
    title: 'Al-Kahf',
    subtitle: 'Surah 18 • 110 verses',
    content: 'And never say about anything, "I will do that tomorrow,"',
    type: SearchContentType.quran,
    icon: '📖',
    reference: 'Al-Kahf: 23',
    arabicText: 'وَلَا تَقُولَنَّ لِشَيْءٍ إِنِّي فَاعِلٌ ذَٰلِكَ غَدًا',
  ),
  SearchResult(
    id: 'q2',
    title: 'Al-Fatihah',
    subtitle: 'Surah 1 • 7 verses',
    content: 'In the name of Allah, the Most Gracious, the Most Merciful.',
    type: SearchContentType.quran,
    icon: '📖',
    reference: 'Al-Fatihah: 1',
    arabicText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
  ),
  SearchResult(
    id: 'q3',
    title: 'Yasin',
    subtitle: 'Surah 36 • 83 verses',
    content: 'Ya, Seen. By the Qur\'an, full of wisdom.',
    type: SearchContentType.quran,
    icon: '📖',
    reference: 'Yasin: 1-2',
    arabicText: 'يس وَالْقُرْآنِ الْحَكِيمِ',
  ),
  SearchResult(
    id: 'q4',
    title: 'Ar-Rahman',
    subtitle: 'Surah 55 • 78 verses',
    content: 'The Most Merciful. Taught the Qur\'an.',
    type: SearchContentType.quran,
    icon: '📖',
    reference: 'Ar-Rahman: 1-2',
    arabicText: 'الرَّحْمَٰنُ عَلَّمَ الْقُرْآنَ',
  ),

  // Hadith Results
  SearchResult(
    id: 'h1',
    title: 'Actions are judged by intentions',
    subtitle: 'Sahih Bukhari • Book of Belief',
    content: 'Actions are judged by intentions, and every person will get what they intended.',
    type: SearchContentType.hadith,
    icon: '📚',
    reference: 'Bukhari 1',
    arabicText: 'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ',
  ),
  SearchResult(
    id: 'h2',
    title: 'Faith is to believe in Allah',
    subtitle: 'Sahih Bukhari • Book of Belief',
    content: 'Faith is to believe in Allah, His angels, His books, His messengers, and the Last Day.',
    type: SearchContentType.hadith,
    icon: '📚',
    reference: 'Bukhari 50',
    arabicText: 'الإِيمَانُ أَنْ تُؤْمِنَ بِاللَّهِ',
  ),
  SearchResult(
    id: 'h3',
    title: 'Whoever Allah wishes good for',
    subtitle: 'Sahih Bukhari • Book of Knowledge',
    content: 'Whoever Allah wishes good for, He gives understanding of the religion.',
    type: SearchContentType.hadith,
    icon: '📚',
    reference: 'Bukhari 71',
    arabicText: 'مَنْ يُرِدِ اللَّهُ بِهِ خَيْرًا',
  ),
  SearchResult(
    id: 'h4',
    title: 'Prayer is the pillar of religion',
    subtitle: 'Sahih Bukhari • Book of Prayer',
    content: 'Prayer is the pillar of religion. Whoever establishes it has established the religion.',
    type: SearchContentType.hadith,
    icon: '📚',
    reference: 'Bukhari 567',
    arabicText: 'الصَّلاَةُ عِمَادُ الدِّينِ',
  ),

  // Book Results
  SearchResult(
    id: 'b1',
    title: 'Riyad us-Saliheen',
    subtitle: 'Imam An-Nawawi • Hadith',
    content: 'A collection of authentic hadiths on ethics, manners, and worship.',
    type: SearchContentType.book,
    icon: '📘',
    reference: 'Hadith Collection',
  ),
  SearchResult(
    id: 'b2',
    title: 'Tafsir Ibn Kathir',
    subtitle: 'Imam Ibn Kathir • Tafsir',
    content: 'One of the most renowned and widely accepted commentaries on the Quran.',
    type: SearchContentType.book,
    icon: '📕',
    reference: 'Tafsir',
  ),
  SearchResult(
    id: 'b3',
    title: 'The Sealed Nectar',
    subtitle: 'Safi-ur-Rahman al-Mubarakpuri • Seerah',
    content: 'A comprehensive biography of the Prophet Muhammad (PBUH).',
    type: SearchContentType.book,
    icon: '📗',
    reference: 'Seerah',
  ),

  // Dua Results
  SearchResult(
    id: 'd1',
    title: 'Morning Dua',
    subtitle: 'Daily Dua • Morning',
    content: 'O Allah, by You we enter the morning and by You we enter the evening.',
    type: SearchContentType.dua,
    icon: '🤲',
    reference: 'Morning Azkar',
    arabicText: 'اللَّهُمَّ بِكَ أَصْبَحْنَا',
  ),
  SearchResult(
    id: 'd2',
    title: 'Evening Dua',
    subtitle: 'Daily Dua • Evening',
    content: 'O Allah, by You we enter the evening and by You we enter the morning.',
    type: SearchContentType.dua,
    icon: '🤲',
    reference: 'Evening Azkar',
    arabicText: 'اللَّهُمَّ بِكَ أَمْسَيْنَا',
  ),
  SearchResult(
    id: 'd3',
    title: 'Dua for Protection',
    subtitle: 'Protection Dua',
    content: 'In the name of Allah, with whose name nothing can cause harm.',
    type: SearchContentType.dua,
    icon: '🤲',
    reference: 'Protection',
    arabicText: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ',
  ),

  // Course Results
  SearchResult(
    id: 'c1',
    title: 'Qur\'an Nazra',
    subtitle: 'Qari Abdul Basit • Beginner',
    content: 'Learn to read the Qur\'an with proper pronunciation and fluency.',
    type: SearchContentType.course,
    icon: '🎓',
    reference: 'Course',
  ),
  SearchResult(
    id: 'c2',
    title: 'Tajweed Rules',
    subtitle: 'Sheikh Mishary Alafasy • Intermediate',
    content: 'Master the rules of Tajweed for beautiful Qur\'an recitation.',
    type: SearchContentType.course,
    icon: '🎯',
    reference: 'Course',
  ),
  SearchResult(
    id: 'c3',
    title: 'Seerah Chapters',
    subtitle: 'Dr. Yasir Qadhi • Beginner',
    content: 'Explore the life of Prophet Muhammad (PBUH) in detail.',
    type: SearchContentType.course,
    icon: '📚',
    reference: 'Course',
  ),
];

// Search function
List<SearchResult> searchAll(String query) {
  if (query.isEmpty) return [];

  final lowerQuery = query.toLowerCase();
  return allSearchResults.where((result) {
    return result.title.toLowerCase().contains(lowerQuery) ||
        result.subtitle.toLowerCase().contains(lowerQuery) ||
        result.content.toLowerCase().contains(lowerQuery) ||
        (result.reference?.toLowerCase().contains(lowerQuery) ?? false);
  }).toList();
}

// Filter by type
List<SearchResult> searchByType(String query, SearchContentType? type) {
  final results = searchAll(query);
  if (type == null) return results;
  return results.where((r) => r.type == type).toList();
}