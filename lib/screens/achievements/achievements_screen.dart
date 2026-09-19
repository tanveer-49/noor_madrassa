// lib/screens/achievements/achievements_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/achievements_data.dart';
import 'package:noor_madrassa/models/achievement_model.dart';
import 'package:noor_madrassa/services/achievement_service.dart';
import 'package:noor_madrassa/screens/achievements/certificate_detail_screen.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final AchievementService _achievementService = Get.put(AchievementService());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Achievements',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            color: context.textColor,
          ),
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        iconTheme: IconThemeData(color: context.textColor),
      ),
      body: Column(
        children: [
          // Stats Card
          _buildStatsCard(context, isDark),

          // Tab Selector (Badges / Certificates)
          _buildTabSelector(context, isDark),

          const SizedBox(height: 16),

          // Content
          Expanded(
            child: Obx(() {
              if (_achievementService.selectedTab.value == 'Badges') {
                return _buildBadgesContent(context, isDark);
              } else {
                return _buildCertificatesContent(context, isDark);
              }
            }),
          ),
        ],
      ),
    );
  }

  // Stats Card
  Widget _buildStatsCard(BuildContext context, bool isDark) {
    final stats = _achievementService.getStats();

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            '🏆',
            '${stats['earned']}',
            'Earned',
          ),
          _buildStatItem(
            context,
            '🎯',
            '${stats['inProgress']}',
            'In Progress',
          ),
          _buildStatItem(
            context,
            '📜',
            '${stats['certificates']}',
            'Certificates',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String icon, String value, String label) {
    return Column(
      children: [
        Text(
          icon,
          style: TextStyle(fontSize: Responsive.fontSize(context, 28)),
        ),
        SizedBox(height: Responsive.height(context, 6)),
        Text(
          value,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 22),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 11),
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  // Tab Selector
  Widget _buildTabSelector(BuildContext context, bool isDark) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTabItem(context, 'Badges', _achievementService.selectedTab.value == 'Badges'),
          _buildTabItem(context, 'Certificates', _achievementService.selectedTab.value == 'Certificates'),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, String label, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _achievementService.changeTab(label),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Responsive.padding(context, 10)),
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
              fontSize: Responsive.fontSize(context, 14),
            ),
          ),
        ),
      ),
    );
  }

  // BADGES CONTENT
  Widget _buildBadgesContent(BuildContext context, bool isDark) {
    return Column(
      children: [
        // Type Filter Chips
        _buildBadgeTypeChips(context, isDark),

        const SizedBox(height: 12),

        // Badges Grid
        Expanded(
          child: Obx(() {
            final badges = _achievementService.getFilteredBadges();
            if (badges.isEmpty) {
              return _buildEmptyState(context, isDark, 'No badges in this category');
            }
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.gridColumns(context),
                crossAxisSpacing: Responsive.padding(context, 12),
                mainAxisSpacing: Responsive.padding(context, 12),
                childAspectRatio: 0.85,
              ),
              itemCount: badges.length,
              itemBuilder: (context, index) {
                return _buildBadgeCard(context, isDark, badges[index]);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildBadgeTypeChips(BuildContext context, bool isDark) {
    final types = getBadgeTypes();

    return Container(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
        itemCount: types.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Obx(() {
              final isSelected = _achievementService.selectedType.value == null;
              return _buildChip(
                context,
                isDark,
                'All',
                isSelected,
                    () => _achievementService.filterByType(null),
              );
            });
          }

          final type = types[index - 1];
          return Obx(() {
            final isSelected = _achievementService.selectedType.value == type;
            return _buildChip(
              context,
              isDark,
              type.label,
              isSelected,
                  () => _achievementService.filterByType(type),
            );
          });
        },
      ),
    );
  }

  Widget _buildChip(BuildContext context, bool isDark, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 13),
            color: isSelected ? Colors.white : context.textSecondaryColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeCard(BuildContext context, bool isDark, AchievementBadge badge) {
    final color = Color(int.parse(badge.color.replaceFirst('#', 'FF'), radix: 16));
    final isEarned = badge.isEarned;

    return Container(
      padding: EdgeInsets.all(Responsive.padding(context, 12)),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: isEarned
            ? Border.all(color: color.withOpacity(0.5), width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Badge Icon
          Container(
            width: Responsive.width(context, 60),
            height: Responsive.width(context, 60),
            decoration: BoxDecoration(
              gradient: isEarned
                  ? LinearGradient(
                colors: [color, color.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
                  : null,
              color: isEarned ? null : (isDark ? AppColors.darkBackground : Colors.grey.shade200),
              shape: BoxShape.circle,
              boxShadow: isEarned
                  ? [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
                  : null,
            ),
            child: Center(
              child: Text(
                badge.icon,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 26),
                  color: isEarned ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: Responsive.height(context, 10)),

          // Title
          Text(
            badge.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 12),
              fontWeight: FontWeight.w600,
              color: isEarned ? context.textColor : context.textSecondaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: Responsive.height(context, 4)),

          // Description
          Text(
            badge.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 10),
              color: context.textSecondaryColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          // Progress (if not earned)
          if (!isEarned && badge.progress > 0) ...[
            SizedBox(height: Responsive.height(context, 8)),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: badge.progress,
                minHeight: 4,
                backgroundColor: isDark ? AppColors.darkBackground : Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            SizedBox(height: Responsive.height(context, 4)),
            Text(
              '${(badge.progress * 100).toInt()}%',
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 9),
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],

          // Earned Date
          if (isEarned && badge.earnedAt != null) ...[
            SizedBox(height: Responsive.height(context, 6)),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.padding(context, 6),
                vertical: Responsive.padding(context, 2),
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Earned',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 8),
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // CERTIFICATES CONTENT
  Widget _buildCertificatesContent(BuildContext context, bool isDark) {
    return Obx(() {
      final certificates = _achievementService.certificates;
      if (certificates.isEmpty) {
        return _buildEmptyState(context, isDark, 'No certificates yet');
      }
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
        itemCount: certificates.length,
        itemBuilder: (context, index) {
          return _buildCertificateCard(context, isDark, certificates[index]);
        },
      );
    });
  }

  Widget _buildCertificateCard(BuildContext context, bool isDark, Certificate certificate) {
    final color = Color(int.parse(certificate.color.replaceFirst('#', 'FF'), radix: 16));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CertificateDetailScreen(certificate: certificate),
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
        child: Row(
          children: [
            // Certificate Icon
            Container(
              width: Responsive.width(context, 60),
              height: Responsive.width(context, 60),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  certificate.icon,
                  style: TextStyle(fontSize: Responsive.fontSize(context, 28)),
                ),
              ),
            ),
            SizedBox(width: Responsive.padding(context, 14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    certificate.title,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      fontWeight: FontWeight.w600,
                      color: context.textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Responsive.height(context, 2)),
                  Text(
                    certificate.courseName,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 11),
                      color: context.textSecondaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Responsive.height(context, 6)),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.padding(context, 6),
                          vertical: Responsive.padding(context, 2),
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          certificate.certificateNumber,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 9),
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Responsive.width(context, 14),
              color: context.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  // Empty State
  Widget _buildEmptyState(BuildContext context, bool isDark, String message) {
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
                Icons.emoji_events,
                size: Responsive.width(context, 50),
                color: AppColors.islamicGold,
              ),
            ),
            SizedBox(height: Responsive.height(context, 20)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 16),
                fontWeight: FontWeight.w600,
                color: context.textColor,
              ),
            ),
            SizedBox(height: Responsive.height(context, 8)),
            Text(
              'Complete more activities to earn rewards',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 13),
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