// lib/screens/hadith/hadith_home_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/hadith_data.dart';
import 'package:noor_madrassa/models/hadith_model.dart';
import 'package:noor_madrassa/screens/hadith/hadith_collection_screen.dart';
import 'package:noor_madrassa/screens/hadith/hadith_reader_screen.dart';
import 'package:noor_madrassa/utils/responsive.dart';

class HadithHomeScreen extends StatefulWidget {
  const HadithHomeScreen({super.key});

  @override
  State<HadithHomeScreen> createState() => _HadithHomeScreenState();
}

class _HadithHomeScreenState extends State<HadithHomeScreen> {
  String _selectedTab = 'Collections';
  List<Hadith> _recentHadiths = [];

  @override
  void initState() {
    super.initState();
    _recentHadiths = dummyHadiths.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmCream,
      appBar: AppBar(
        title: Text(
          'Hadith Collections',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
          ),
        ),
        backgroundColor: AppColors.warmCream,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: Responsive.width(context, 24)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border, size: Responsive.width(context, 24)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Featured Hadith Card
          _buildFeaturedHadith(context),

          SizedBox(height: Responsive.height(context, 16)),

          // Tab Selector
          _buildTabSelector(context),

          SizedBox(height: Responsive.height(context, 16)),

          // Content based on selected tab
          Expanded(
            child: _selectedTab == 'Collections'
                ? _buildCollectionsGrid(context)
                : _buildRecentHadiths(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedHadith(BuildContext context) {
    final hadith = dummyHadiths[0];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      padding: EdgeInsets.all(Responsive.padding(context, 16)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.deepForest, AppColors.emerald],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.emerald.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
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
                '⭐ Featured Hadith',
                style: TextStyle(
                  color: AppColors.islamicGold,
                  fontSize: Responsive.fontSize(context, 14),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.padding(context, 8),
                  vertical: Responsive.padding(context, 4),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  hadith.grade,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.fontSize(context, 10),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.height(context, 12)),
          Text(
            hadith.arabicText,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 20),
              fontFamily: 'Uthmanic',
              color: Colors.white,
              height: 1.8,
            ),
          ),
          SizedBox(height: Responsive.height(context, 12)),
          Text(
            '"${hadith.englishTranslation}"',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              color: Colors.white70,
              height: 1.6,
            ),
          ),
          SizedBox(height: Responsive.height(context, 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                hadith.reference,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 12),
                  color: Colors.white60,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.white, size: Responsive.width(context, 20)),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.white, size: Responsive.width(context, 20)),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabItem(context, 'Collections', _selectedTab == 'Collections'),
          _buildTabItem(context, 'Recent', _selectedTab == 'Recent'),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, String label, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = label;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Responsive.height(context, 10)),
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
              fontSize: Responsive.fontSize(context, 14),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionsGrid(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.gridColumns(context),
        crossAxisSpacing: Responsive.padding(context, 12),
        mainAxisSpacing: Responsive.padding(context, 12),
        childAspectRatio: Responsive.cardAspectRatio(context),
      ),
      itemCount: dummyCollections.length,
      itemBuilder: (context, index) {
        final collection = dummyCollections[index];
        return _buildCollectionCard(context, collection);
      },
    );
  }

  // lib/screens/hadith/hadith_home_screen.dart - Update collection card

  Widget _buildCollectionCard(BuildContext context, HadithCollection collection) {
    final color = Color(int.parse(collection.color.replaceFirst('#', 'FF'), radix: 16));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HadithCollectionScreen(collection: collection),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(Responsive.padding(context, 12)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // IMPORTANT
          children: [
            Container(
              width: Responsive.width(context, 45),
              height: Responsive.height(context, 45),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  collection.icon,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 24),
                  ),
                ),
              ),
            ),
            SizedBox(height: Responsive.height(context, 6)),
            Text(
              collection.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 12),
                fontWeight: FontWeight.w600,
                color: AppColors.deepForest,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: Responsive.height(context, 1)),
            Text(
              collection.nameArabic,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 10),
                color: AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: Responsive.height(context, 1)),
            Text(
              '${collection.totalHadith} Ahadith',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 9),
                color: AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentHadiths(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      itemCount: _recentHadiths.length,
      itemBuilder: (context, index) {
        final hadith = _recentHadiths[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HadithReaderScreen(hadith: hadith),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(bottom: Responsive.height(context, 8)),
            padding: EdgeInsets.all(Responsive.padding(context, 16)),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hadith.reference,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 12),
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.padding(context, 8),
                        vertical: Responsive.padding(context, 2),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightMint,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        hadith.grade,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 10),
                          color: AppColors.emerald,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.height(context, 8)),
                Text(
                  hadith.englishTranslation,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    color: AppColors.textPrimary,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}