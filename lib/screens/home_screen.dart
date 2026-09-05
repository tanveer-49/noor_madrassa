// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/screens/quran/quran_home_screen.dart';
import 'package:noor_madrassa/screens/hadith/hadith_home_screen.dart';
import 'package:noor_madrassa/screens/library/books_home_screen.dart';
import 'package:noor_madrassa/screens/profile/profile_screen.dart';
import 'package:noor_madrassa/widgets/bottom_nav.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const QuranHomeScreen(),
    const HadithHomeScreen(),
    const BooksHomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// Home Content Widget -
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assalamu Alaikum! 👋',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: context.textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Wednesday, 3 September 2026',
                        style: TextStyle(
                          fontSize: 14,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.emerald,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Hero Card -
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.deepForest, AppColors.emerald],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.emerald.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Continue Your Journey',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Al-Kahf: Verse 23',
                      style: TextStyle(
                        color: AppColors.islamicGold,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Uthmanic',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'And never say about anything, "I will do that tomorrow,"',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: 0.45,
                              minHeight: 6,
                              backgroundColor: Colors.white24,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.islamicGold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          '45%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Quick Actions
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: context.textColor,
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildQuickAction(context, Icons.menu_book, 'Qur\'an'),
                  _buildQuickAction(context, Icons.chrome_reader_mode, 'Hadith'),
                  _buildQuickAction(context, Icons.local_library, 'Duas'),
                  _buildQuickAction(context, Icons.school, 'Courses'),
                ],
              ),

              const SizedBox(height: 24),

              // Daily Ayah -
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(isDark ? 0.1 : 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daily Ayah',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.textColor,
                          ),
                        ),
                        const Icon(
                          Icons.favorite_border,
                          color: AppColors.islamicGold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'وَلَا تَحْسَبَنَّ اللَّهَ غَافِلًا عَمَّا يَعْمَلُ الظَّالِمُونَ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Uthmanic',
                        color: AppColors.deepForest,
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '"And never think that Allah is unaware of what the wrongdoers do."',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: context.textSecondaryColor,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Madrassa Progress -
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightMint,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: isDark ? AppColors.softEmerald : AppColors.emerald,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Madrassa Progress',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: context.textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '22 of 30 lessons completed',
                            style: TextStyle(
                              fontSize: 14,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '75%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.softEmerald : AppColors.emerald,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Recent Items
              Text(
                'Recent',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: context.textColor,
                ),
              ),
              const SizedBox(height: 12),
              _buildRecentItem(context, '📖', 'Al-Kahf', 'Surah 18 • 1 min ago'),
              _buildRecentItem(context, '📚', 'Sahih Bukhari', 'Book of Belief • 15 min ago'),
              _buildRecentItem(context, '🎓', 'Fiqh of Salah', 'Lesson 7 • 2 hours ago'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: context.cardColor,  //
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(context.isDarkMode ? 0.1 : 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColors.emerald,
              size: 28,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentItem(BuildContext context, String emoji, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(context.isDarkMode ? 0.1 : 0.05),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.textColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: context.textSecondaryColor,
          ),
        ],
      ),
    );
  }
}