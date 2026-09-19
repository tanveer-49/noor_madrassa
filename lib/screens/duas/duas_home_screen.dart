// lib/screens/duas/duas_home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/models/dua_model.dart';
import 'package:noor_madrassa/services/dua_service.dart';
import 'package:noor_madrassa/screens/duas/dua_detail_screen.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';
import 'package:noor_madrassa/data/duas_data.dart';

class DuasHomeScreen extends StatefulWidget {
  const DuasHomeScreen({super.key});

  @override
  State<DuasHomeScreen> createState() => _DuasHomeScreenState();
}

class _DuasHomeScreenState extends State<DuasHomeScreen> {
  final DuaService _duaService = Get.put(DuaService());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Duas & Azkar',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            color: context.textColor,
          ),
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        actions: [
          // Favorites Toggle
          Obx(() => IconButton(
            icon: Icon(
              _duaService.showFavoritesOnly.value
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: _duaService.showFavoritesOnly.value
                  ? AppColors.islamicGold
                  : context.textColor,
            ),
            onPressed: () => _duaService.toggleFavoritesOnly(),
          )),
        ],
      ),
      body: Column(
        children: [
          // Featured Dua Card
          _buildFeaturedDua(context, isDark),

          // Category Chips
          _buildCategoryChips(context, isDark),

          const SizedBox(height: 16),

          // Duas List
          Expanded(
            child: Obx(() {
              final duas = _duaService.getFilteredDuas();
              if (duas.isEmpty) {
                return _buildEmptyState(context, isDark);
              }
              return _buildDuasList(context, isDark, duas);
            }),
          ),
        ],
      ),
    );
  }

  // Featured Dua Card
  Widget _buildFeaturedDua(BuildContext context, bool isDark) {
    final featuredDua = dummyDuas[0];

    return Container(
      margin: EdgeInsets.all(Responsive.padding(context, 16)),
      padding: EdgeInsets.all(Responsive.padding(context, 16)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dua of the Day',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
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
                  featuredDua.category.label,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 10),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.height(context, 12)),
          Text(
            featuredDua.title,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 16),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.height(context, 8)),
          Text(
            featuredDua.arabicText,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontFamily: 'Uthmanic',
              color: Colors.white,
              height: 1.8,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: Responsive.height(context, 8)),
          Text(
            '"${featuredDua.translation}"',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 12),
              color: Colors.white70,
              height: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: Responsive.height(context, 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                featuredDua.reference,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 11),
                  color: Colors.white60,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DuaDetailScreen(dua: featuredDua),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.padding(context, 12),
                    vertical: Responsive.padding(context, 6),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Read More',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 11),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: Responsive.padding(context, 4)),
                      Icon(
                        Icons.arrow_forward,
                        size: Responsive.width(context, 14),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Category Chips
  Widget _buildCategoryChips(BuildContext context, bool isDark) {
    final categories = getDuaCategories();

    return Container(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
        itemCount: categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Obx(() {
              final isSelected = _duaService.selectedCategory.value == null;
              return GestureDetector(
                onTap: () => _duaService.filterByCategory(null),
                child: Container(
                  margin: EdgeInsets.only(right: Responsive.padding(context, 8)),
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.padding(context, 16),
                    vertical: Responsive.padding(context, 8),
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.emerald : context.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.emerald
                          : (isDark ? Colors.grey.shade700 : Colors.grey.shade200),
                    ),
                  ),
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 13),
                      color: isSelected ? Colors.white : context.textSecondaryColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            });
          }

          final category = categories[index - 1];
          return Obx(() {
            final isSelected = _duaService.selectedCategory.value == category;
            final color = Color(int.parse(category.color.replaceFirst('#', 'FF'), radix: 16));

            return GestureDetector(
              onTap: () => _duaService.filterByCategory(category),
              child: Container(
                margin: EdgeInsets.only(right: Responsive.padding(context, 8)),
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.padding(context, 16),
                  vertical: Responsive.padding(context, 8),
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.emerald : context.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.emerald
                        : (isDark ? Colors.grey.shade700 : Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      category.icon,
                      style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
                    ),
                    SizedBox(width: Responsive.padding(context, 4)),
                    Text(
                      category.label,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 13),
                        color: isSelected ? Colors.white : context.textSecondaryColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  // Duas List
  Widget _buildDuasList(BuildContext context, bool isDark, List<Dua> duas) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      itemCount: duas.length,
      itemBuilder: (context, index) {
        return _buildDuaCard(context, isDark, duas[index]);
      },
    );
  }

  // Dua Card
  Widget _buildDuaCard(BuildContext context, bool isDark, Dua dua) {
    final color = Color(int.parse(dua.category.color.replaceFirst('#', 'FF'), radix: 16));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DuaDetailScreen(dua: dua),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Responsive.height(context, 12)),
        padding: EdgeInsets.all(Responsive.padding(context, 14)),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(14),
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
            Row(
              children: [
                Container(
                  width: Responsive.width(context, 40),
                  height: Responsive.width(context, 40),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      dua.category.icon,
                      style: TextStyle(fontSize: Responsive.fontSize(context, 20)),
                    ),
                  ),
                ),
                SizedBox(width: Responsive.padding(context, 12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dua.title,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          fontWeight: FontWeight.w600,
                          color: context.textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        dua.titleArabic,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 12),
                          color: context.textSecondaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Favorite Button
                Obx(() => GestureDetector(
                  onTap: () => _duaService.toggleFavorite(dua.id),
                  child: Icon(
                    _duaService.isFavorite(dua.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: _duaService.isFavorite(dua.id)
                        ? AppColors.islamicGold
                        : context.textSecondaryColor,
                    size: Responsive.width(context, 22),
                  ),
                )),
              ],
            ),
            SizedBox(height: Responsive.height(context, 10)),
            Text(
              dua.arabicText,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 16),
                fontFamily: 'Uthmanic',
                color: context.textColor,
                height: 1.6,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: Responsive.height(context, 8)),
            Text(
              dua.translation,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 12),
                color: context.textSecondaryColor,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: Responsive.height(context, 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.padding(context, 8),
                    vertical: Responsive.padding(context, 4),
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    dua.category.label,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 10),
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  dua.reference,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 10),
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Empty State
  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Responsive.padding(context, 32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Responsive.width(context, 100),
              height: Responsive.width(context, 100),
              decoration: BoxDecoration(
                color: AppColors.islamicGold.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border,
                size: Responsive.width(context, 50),
                color: AppColors.islamicGold,
              ),
            ),
            SizedBox(height: Responsive.height(context, 20)),
            Text(
              'No Duas Found',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 18),
                fontWeight: FontWeight.bold,
                color: context.textColor,
              ),
            ),
            SizedBox(height: Responsive.height(context, 8)),
            Text(
              'Try a different category or add favorites',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 14),
                color: context.textSecondaryColor,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}