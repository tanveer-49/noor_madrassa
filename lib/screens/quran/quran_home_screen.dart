// lib/screens/quran/quran_home_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/quran_data.dart';
import 'package:noor_madrassa/models/surah_model.dart';
import 'package:noor_madrassa/screens/quran/surah_reader_screen.dart';

class QuranHomeScreen extends StatefulWidget {
  const QuranHomeScreen({super.key});

  @override
  State<QuranHomeScreen> createState() => _QuranHomeScreenState();
}

class _QuranHomeScreenState extends State<QuranHomeScreen> {
  String _searchQuery = '';
  List<Surah> _filteredSurahs = [];

  @override
  void initState() {
    super.initState();
    _filteredSurahs = dummySurahs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      appBar: AppBar(
        title: const Text('Al-Qur\'an'),
        backgroundColor: AppColors.warmCream,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              // Bookmarks
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick Stats Card
          _buildQuickStats(),

          const SizedBox(height: 16),

          // Tabs: Surahs / Juz / Bookmarks
          _buildTabs(),

          const SizedBox(height: 16),

          // Surah List
          Expanded(
            child: _buildSurahList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.emerald, AppColors.softEmerald],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('📖', '114', 'Surahs'),
          _buildStatItem('📜', '6236', 'Verses'),
          _buildStatItem('⭐', '30', 'Juz'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String icon, String number, String label) {
    return Column(
      children: [
        Text(
          icon,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          number,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabItem('Surahs', true),
          _buildTabItem('Juz', false),
          _buildTabItem('Bookmarks', false),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.emerald : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSurahList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredSurahs.length,
      itemBuilder: (context, index) {
        final surah = _filteredSurahs[index];
        return _buildSurahTile(surah);
      },
    );
  }

  Widget _buildSurahTile(Surah surah) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SurahReaderScreen(surah: surah),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Surah Number
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.lightMint,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${surah.id}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.emerald,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Surah Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.nameArabic,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.deepForest,
                    ),
                  ),
                  Text(
                    '${surah.nameEnglish} • ${surah.versesCount} verses • ${surah.placeOfRevelation}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Translation and Arrow
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  surah.translation,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: surah.placeOfRevelation == 'Makki'
                        ? Colors.orange.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    surah.placeOfRevelation,
                    style: TextStyle(
                      fontSize: 10,
                      color: surah.placeOfRevelation == 'Makki'
                          ? Colors.orange[700]
                          : Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}