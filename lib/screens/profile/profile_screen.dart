// lib/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/user_data.dart';
import 'package:noor_madrassa/models/user_model.dart';
import 'package:noor_madrassa/screens/profile/settings_screen.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;
  bool _showAllActivities = false;

  @override
  void initState() {
    super.initState();
    user = dummyUser;
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(user.avatarColor.replaceFirst('#', 'FF'), radix: 16));

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            color: context.textColor,
          ),
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: context.textColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.padding(context, 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildProfileHeader(context, color),

            SizedBox(height: Responsive.height(context, 20)),

            // Stats Row
            _buildStatsRow(context),

            SizedBox(height: Responsive.height(context, 20)),

            // Progress Section
            _buildProgressSection(context),

            SizedBox(height: Responsive.height(context, 20)),

            // Recent Activity
            _buildRecentActivity(context),

            SizedBox(height: Responsive.height(context, 16)),

            // Quick Actions
            _buildQuickActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, Color color) {
    return Container(
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
      child: Row(
        children: [
          Container(
            width: Responsive.width(context, 70),
            height: Responsive.height(context, 70),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 32),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: Responsive.padding(context, 16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 20),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: Responsive.height(context, 8)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '🕌 Madrassa Student',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(context, '📖', '${user.quranReadingStreak}', 'Day Streak', AppColors.emerald),
        SizedBox(width: Responsive.padding(context, 12)),
        _buildStatCard(context, '📚', '${user.lessonsCompleted}/${user.totalLessons}', 'Lessons', AppColors.softEmerald),
        SizedBox(width: Responsive.padding(context, 12)),
        _buildStatCard(context, '🏆', '${user.certificates}', 'Certificates', AppColors.islamicGold),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String icon, String value, String label, Color color) {
    return Expanded(
      child: Container(
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
          children: [
            Text(
              icon,
              style: TextStyle(fontSize: Responsive.fontSize(context, 24)),
            ),
            SizedBox(height: Responsive.height(context, 4)),
            Text(
              value,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 18),
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 10),
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.padding(context, 16)),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(context.isDarkMode ? 0.1 : 0.05),
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
                'Overall Progress',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 16),
                  fontWeight: FontWeight.w600,
                  color: context.textColor,
                ),
              ),
              Text(
                '${(user.overallProgress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 16),
                  fontWeight: FontWeight.bold,
                  color: AppColors.emerald,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.height(context, 8)),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: user.overallProgress,
              minHeight: 8,
              backgroundColor: context.isDarkMode ? AppColors.darkCard : AppColors.lightMint,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.emerald),
            ),
          ),
          SizedBox(height: Responsive.height(context, 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProgressItem(context, '📖', 'Qur\'an', '${user.quranReadingStreak}%'),
              _buildProgressItem(context, '📚', 'Hadith', '65%'),
              _buildProgressItem(context, '📘', 'Books', '${(user.overallProgress * 100).toInt()}%'),
              _buildProgressItem(context, '🎯', 'Courses', '${((user.lessonsCompleted / user.totalLessons) * 100).toInt()}%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem(BuildContext context, String icon, String label, String progress) {
    return Column(
      children: [
        Text(icon, style: TextStyle(fontSize: Responsive.fontSize(context, 20))),
        SizedBox(height: Responsive.height(context, 2)),
        Text(
          progress,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.bold,
            color: AppColors.emerald,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 10),
            color: context.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    final activities = _showAllActivities ? dummyActivities : dummyActivities.take(3).toList();

    return Container(
      padding: EdgeInsets.all(Responsive.padding(context, 16)),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(context.isDarkMode ? 0.1 : 0.05),
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
                'Recent Activity',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 16),
                  fontWeight: FontWeight.w600,
                  color: context.textColor,
                ),
              ),
              if (dummyActivities.length > 3)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showAllActivities = !_showAllActivities;
                    });
                  },
                  child: Text(
                    _showAllActivities ? 'Show Less' : 'See All',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: AppColors.emerald,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: Responsive.height(context, 12)),
          ...activities.map((activity) => _buildActivityItem(context, activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context, Map<String, dynamic> activity) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Responsive.padding(context, 10)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.width(context, 40),
            height: Responsive.height(context, 40),
            decoration: BoxDecoration(
              color: context.isDarkMode ? AppColors.darkCard : AppColors.lightMint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                activity['icon'],
                style: TextStyle(fontSize: Responsive.fontSize(context, 18)),
              ),
            ),
          ),
          SizedBox(width: Responsive.padding(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'],
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    fontWeight: FontWeight.w500,
                    color: context.textColor,
                  ),
                ),
                Text(
                  activity['subtitle'],
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
                    color: context.textSecondaryColor,
                  ),
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
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        _buildQuickActionItem(context, '📖', 'Bookmarks', () {}),
        SizedBox(width: Responsive.padding(context, 12)),
        _buildQuickActionItem(context, '🏆', 'Achievements', () {}),
        SizedBox(width: Responsive.padding(context, 12)),
        _buildQuickActionItem(context, '📊', 'Statistics', () {}),
      ],
    );
  }

  Widget _buildQuickActionItem(BuildContext context, String icon, String label, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
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
            children: [
              Text(
                icon,
                style: TextStyle(fontSize: Responsive.fontSize(context, 24)),
              ),
              SizedBox(height: Responsive.height(context, 4)),
              Text(
                label,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 11),
                  color: context.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}