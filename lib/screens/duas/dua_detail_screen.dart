// lib/screens/duas/dua_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/models/dua_model.dart';
import 'package:noor_madrassa/services/dua_service.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class DuaDetailScreen extends StatefulWidget {
  final Dua dua;

  const DuaDetailScreen({super.key, required this.dua});

  @override
  State<DuaDetailScreen> createState() => _DuaDetailScreenState();
}

class _DuaDetailScreenState extends State<DuaDetailScreen> {
  final DuaService _duaService = Get.find();
  double _fontSize = 20;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = Color(int.parse(widget.dua.category.color.replaceFirst('#', 'FF'), radix: 16));

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.dua.title,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 16),
            color: context.textColor,
          ),
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        iconTheme: IconThemeData(color: context.textColor),
        actions: [
          // Favorite
          Obx(() => IconButton(
            icon: Icon(
              _duaService.isFavorite(widget.dua.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: _duaService.isFavorite(widget.dua.id)
                  ? AppColors.islamicGold
                  : context.textColor,
            ),
            onPressed: () => _duaService.toggleFavorite(widget.dua.id),
          )),
          // Share
          IconButton(
            icon: Icon(Icons.share, color: context.textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.padding(context, 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.padding(context, 12),
                vertical: Responsive.padding(context, 6),
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.dua.category.icon,
                    style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
                  ),
                  SizedBox(width: Responsive.padding(context, 6)),
                  Text(
                    widget.dua.category.label,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.height(context, 16)),

            // Title Arabic
            Text(
              widget.dua.titleArabic,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 24),
                fontFamily: 'Uthmanic',
                fontWeight: FontWeight.bold,
                color: context.textColor,
              ),
            ),
            SizedBox(height: Responsive.height(context, 4)),
            Text(
              widget.dua.title,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 16),
                color: context.textSecondaryColor,
              ),
            ),
            SizedBox(height: Responsive.height(context, 24)),

            // Arabic Text Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Responsive.padding(context, 20)),
              decoration: BoxDecoration(
                gradient: AppGradients.primaryGradient,
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
                children: [
                  Text(
                    widget.dua.arabicText,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, _fontSize),
                      fontFamily: 'Uthmanic',
                      color: Colors.white,
                      height: 2.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.height(context, 20)),

            // Transliteration
            _buildSectionCard(
              context,
              isDark,
              'Transliteration',
              widget.dua.transliteration,
              italic: true,
            ),
            SizedBox(height: Responsive.height(context, 16)),

            // Translation
            _buildSectionCard(
              context,
              isDark,
              'Translation',
              widget.dua.translation,
            ),
            SizedBox(height: Responsive.height(context, 16)),

            // Reference
            Container(
              padding: EdgeInsets.all(Responsive.padding(context, 14)),
              decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.menu_book,
                    color: color,
                    size: Responsive.width(context, 20),
                  ),
                  SizedBox(width: Responsive.padding(context, 10)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reference',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 11),
                            color: context.textSecondaryColor,
                          ),
                        ),
                        Text(
                          widget.dua.reference,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 14),
                            fontWeight: FontWeight.w600,
                            color: context.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.height(context, 20)),

            // Font Size Control
            Container(
              padding: EdgeInsets.all(Responsive.padding(context, 14)),
              decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Font Size',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 13),
                      color: context.textColor,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: context.textColor),
                        onPressed: () {
                          setState(() {
                            if (_fontSize > 16) _fontSize -= 2;
                          });
                        },
                      ),
                      Text(
                        '${_fontSize.toInt()}',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          fontWeight: FontWeight.w600,
                          color: context.textColor,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: context.textColor),
                        onPressed: () {
                          setState(() {
                            if (_fontSize < 32) _fontSize += 2;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.height(context, 20)),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.share, color: AppColors.emerald),
                    label: Text(
                      'Share',
                      style: TextStyle(color: AppColors.emerald),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.padding(context, 12),
                      ),
                      side: const BorderSide(color: AppColors.emerald),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Responsive.padding(context, 12)),
                Expanded(
                  child: Obx(() => ElevatedButton.icon(
                    onPressed: () => _duaService.toggleFavorite(widget.dua.id),
                    icon: Icon(
                      _duaService.isFavorite(widget.dua.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white,
                    ),
                    label: Text(
                      _duaService.isFavorite(widget.dua.id)
                          ? 'Saved'
                          : 'Save',
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.emerald,
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.padding(context, 12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )),
                ),
              ],
            ),
            SizedBox(height: Responsive.height(context, 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
      BuildContext context,
      bool isDark,
      String title,
      String content, {
        bool italic = false,
      }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.padding(context, 14)),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 12),
              color: AppColors.emerald,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: Responsive.height(context, 8)),
          Text(
            content,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              color: context.textColor,
              height: 1.6,
              fontStyle: italic ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}