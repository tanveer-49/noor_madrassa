// lib/data/books_data.dart
import '../models/book_model.dart';


List<Book> dummyBooks = [
  Book(
    id: '1',
    title: 'Riyad us-Saliheen',
    titleArabic: 'رياض الصالحين',
    author: 'Imam An-Nawawi',
    authorArabic: 'الإمام النووي',
    category: 'Hadith',
    description: 'A collection of authentic hadiths on ethics, manners, and worship compiled by Imam An-Nawawi.',
    pages: 600,
    currentPage: 45,
    progress: 0.15,
    coverColor: '#0F5C4D',
    icon: '📖',
    chapters: ['Chapter 1: Sincerity', 'Chapter 2: Repentance', 'Chapter 3: Patience'],
  ),
  Book(
    id: '2',
    title: 'Tafsir Ibn Kathir',
    titleArabic: 'تفسير ابن كثير',
    author: 'Imam Ibn Kathir',
    authorArabic: 'الإمام ابن كثير',
    category: 'Tafsir',
    description: 'One of the most renowned and widely accepted commentaries on the Quran.',
    pages: 1200,
    currentPage: 0,
    progress: 0.0,
    coverColor: '#187A64',
    icon: '📕',
    chapters: ['Surah Al-Fatihah', 'Surah Al-Baqarah', 'Surah Al-Imran'],
  ),
  Book(
    id: '3',
    title: 'Kitab al-Tawhid',
    titleArabic: 'كتاب التوحيد',
    author: 'Imam Muhammad ibn Abd al-Wahhab',
    authorArabic: 'الإمام محمد بن عبد الوهاب',
    category: 'Aqeedah',
    description: 'A fundamental book on Islamic monotheism and the core beliefs of Islam.',
    pages: 200,
    currentPage: 30,
    progress: 0.20,
    coverColor: '#C7A44A',
    icon: '📗',
    chapters: ['Chapter 1: Tawhid', 'Chapter 2: Shirk', 'Chapter 3: Tawakkul'],
  ),
  Book(
    id: '4',
    title: 'The Sealed Nectar',
    titleArabic: 'الرحيق المختوم',
    author: 'Safi-ur-Rahman al-Mubarakpuri',
    authorArabic: 'صفي الرحمن المباركفوري',
    category: 'Seerah',
    description: 'A comprehensive biography of the Prophet Muhammad (PBUH), winner of the Seerah competition.',
    pages: 500,
    currentPage: 120,
    progress: 0.35,
    coverColor: '#8B6B3D',
    icon: '📘',
    chapters: ['Chapter 1: Arabia', 'Chapter 2: Birth', 'Chapter 3: Prophethood'],
  ),
  Book(
    id: '5',
    title: 'Al-Adab al-Mufrad',
    titleArabic: 'الأدب المفرد',
    author: 'Imam Bukhari',
    authorArabic: 'الإمام البخاري',
    category: 'Akhlaq',
    description: 'A collection of hadiths on manners, ethics, and good character compiled by Imam Bukhari.',
    pages: 350,
    currentPage: 0,
    progress: 0.0,
    coverColor: '#4A5A55',
    icon: '📙',
    chapters: ['Chapter 1: Parents', 'Chapter 2: Kindness', 'Chapter 3: Neighbors'],
  ),
  Book(
    id: '6',
    title: 'Fiqh al-Sunnah',
    titleArabic: 'فقه السنة',
    author: 'Sayyid Sabiq',
    authorArabic: 'السيد سابق',
    category: 'Fiqh',
    description: 'A comprehensive guide to Islamic jurisprudence based on authentic sources.',
    pages: 800,
    currentPage: 200,
    progress: 0.40,
    coverColor: '#2E7D32',
    icon: '📚',
    chapters: ['Chapter 1: Taharah', 'Chapter 2: Salah', 'Chapter 3: Zakat'],
  ),
];

List<Book> getBooksByCategory(String category) {
  return dummyBooks.where((book) => book.category == category).toList();
}

List<String> getCategories() {
  return ['All', 'Hadith', 'Tafsir', 'Aqeedah', 'Seerah', 'Akhlaq', 'Fiqh'];
}