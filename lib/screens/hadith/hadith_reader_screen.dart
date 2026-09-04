// lib/screens/hadith/hadith_reader_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/models/hadith_model.dart';

class HadithReaderScreen extends StatefulWidget {
  final Hadith hadith;

  const HadithReaderScreen({super.key, required this.hadith});

  @override
  State<HadithReaderScreen> createState() => _HadithReaderScreenState();
}

class _HadithReaderScreenState extends State<HadithReaderScreen> {
  bool _showTranslation = true;
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      backgroundColor: AppColors.warmCream,
      appBar: AppBar(
        title: const Text('Hadith Detail'),
        backgroundColor: AppColors.warmCream,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? AppColors.islamicGold : null,
            ),
            onPressed: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.hadith.reference,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.lightMint,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.hadith.grade,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 10 : 12,
                      color: AppColors.emerald,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.lightMint,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chapter: ${widget.hadith.chapter}',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.deepForest,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.hadith.chapterArabic.isNotEmpty)
                    Text(
                      widget.hadith.chapterArabic,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 12 : 14,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    widget.hadith.arabicText,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : 22,
                      fontFamily: 'Uthmanic',
                      color: AppColors.deepForest,
                      height: 2.0,
                    ),
                    softWrap: true,
                  ),
                  const Divider(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Translation',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Switch(
                        value: _showTranslation,
                        onChanged: (value) {
                          setState(() {
                            _showTranslation = value;
                          });
                        },
                        activeColor: AppColors.emerald,
                      ),
                    ],
                  ),

                  if (_showTranslation) ...[
                    const SizedBox(height: 12),
                    Text(
                      widget.hadith.englishTranslation,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        color: AppColors.textPrimary,
                        height: 1.8,
                      ),
                      softWrap: true,
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),


            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.share, size: isSmallScreen ? 16 : 20),
                    label: Text(
                      'Share',
                      style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 10 : 12),
                      side: const BorderSide(color: AppColors.emerald),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, size: isSmallScreen ? 16 : 20),
                    label: Text(
                      'Back',
                      style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.emerald,
                      padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 10 : 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}