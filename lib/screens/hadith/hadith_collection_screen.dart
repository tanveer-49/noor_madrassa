// lib/screens/hadith/hadith_collection_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/hadith_data.dart';
import 'package:noor_madrassa/models/hadith_model.dart';
import 'package:noor_madrassa/screens/hadith/hadith_reader_screen.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class HadithCollectionScreen extends StatelessWidget {
  final HadithCollection collection;

  const HadithCollectionScreen({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(collection.color.replaceFirst('#', 'FF'), radix: 16));
    final collectionHadiths = dummyHadiths
        .where((h) => h.collectionId == collection.id)
        .toList();

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          collection.name,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 18),
            color: context.textColor,
          ),
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
      ),
      body: Column(
        children: [
          // Collection Info Card
          Container(
            margin: EdgeInsets.all(Responsive.padding(context, 12)),
            padding: EdgeInsets.all(Responsive.padding(context, 12)),
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(context.isDarkMode ? 0.1 : 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: Responsive.width(context, 50),
                  height: Responsive.height(context, 50),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      collection.icon,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 28),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Responsive.padding(context, 12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        collection.name,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 16),
                          fontWeight: FontWeight.bold,
                          color: context.textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        collection.nameArabic,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 13),
                          color: context.textSecondaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Responsive.height(context, 2)),
                      Text(
                        '${collection.totalHadith} Ahadith • ${collection.author}',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 11),
                          color: context.textSecondaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Hadith List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.padding(context, 12),
                vertical: Responsive.padding(context, 4),
              ),
              itemCount: collectionHadiths.length,
              itemBuilder: (context, index) {
                final hadith = collectionHadiths[index];
                return _buildHadithTile(context, hadith);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHadithTile(BuildContext context, Hadith hadith) {
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
        padding: EdgeInsets.all(Responsive.padding(context, 12)),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    hadith.hadithNumber,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 11),
                      color: AppColors.emerald,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.padding(context, 6),
                    vertical: Responsive.padding(context, 1),
                  ),
                  decoration: BoxDecoration(
                    color: context.isDarkMode ? AppColors.darkCard : AppColors.lightMint,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    hadith.grade,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 9),
                      color: AppColors.emerald,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.height(context, 6)),

            // Arabic Text
            Container(
              width: double.infinity,
              child: Text(
                hadith.arabicText,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 15),
                  fontFamily: 'Uthmanic',
                  color: context.textColor,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            SizedBox(height: Responsive.height(context, 6)),

            // Translation
            Text(
              hadith.englishTranslation,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 12),
                color: context.textSecondaryColor,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}