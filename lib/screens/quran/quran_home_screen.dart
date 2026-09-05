// lib/screens/quran/quran_home_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/quran_data.dart';
import 'package:noor_madrassa/models/surah_model.dart';
import 'package:noor_madrassa/screens/quran/surah_reader_screen.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

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
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Al-Qur\'an',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            color: context.textColor,
          ),
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: context.textColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border, color: context.textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [

          _buildQuickStats(context),

          const SizedBox(height: 16),

          // Tabs
          _buildTabs(context),

          const SizedBox(height: 16),

          // Surah List
          Expanded(
            child: _buildSurahList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.emerald.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
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

  Widget _buildTabs(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabItem(context, 'Surahs', true),
          _buildTabItem(context, 'Juz', false),
          _buildTabItem(context, 'Bookmarks', false),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, String label, bool isSelected) {
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
            color: isSelected ? Colors.white : context.textSecondaryColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSurahList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredSurahs.length,
      itemBuilder: (context, index) {
        final surah = _filteredSurahs[index];
        return _buildSurahTile(context, surah);
      },
    );
  }

  Widget _buildSurahTile(BuildContext context, Surah surah) {
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
          color: context.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(context.isDarkMode ? 0.1 : 0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: context.isDarkMode ? AppColors.darkCard : AppColors.lightMint,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${surah.id}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.emerald,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.nameArabic,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: context.textColor,
                    ),
                  ),
                  Text(
                    '${surah.nameEnglish} • ${surah.versesCount} verses • ${surah.placeOfRevelation}',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  surah.translation,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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