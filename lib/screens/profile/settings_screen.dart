// lib/screens/profile/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/user_data.dart';
import 'package:noor_madrassa/services/theme_service.dart';
import 'package:noor_madrassa/utils/responsive.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ThemeService _themeService = Get.find();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.warmCream,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            color: isDark ? AppColors.white : AppColors.textPrimary,
          ),
        ),
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.warmCream,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? AppColors.white : AppColors.textPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.padding(context, 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Summary
            _buildUserSummary(context, isDark),

            SizedBox(height: Responsive.height(context, 20)),

            // Preferences Section
            _buildSettingsSection(context, isDark, 'Preferences', [
              _buildLanguageSetting(context, isDark),
              _buildThemeSetting(context, isDark),
              _buildFontSizeSetting(context, isDark),
            ]),

            SizedBox(height: Responsive.height(context, 16)),

            // Content Section
            _buildSettingsSection(context, isDark, 'Content', [
              _buildAudioSetting(context, isDark),
              _buildTranslationSetting(context, isDark),
            ]),

            SizedBox(height: Responsive.height(context, 16)),

            // Support Section
            _buildSettingsSection(context, isDark, 'Support', [
              _buildNotificationsSetting(context, isDark),
              _buildDownloadsSetting(context, isDark),
              _buildAboutSetting(context, isDark),
            ]),

            SizedBox(height: Responsive.height(context, 24)),

            // Version Info
            Center(
              child: Column(
                children: [
                  Text(
                    'Noor Madrassa',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 16),
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.white : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 4)),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 4)),
                  Text(
                    'Learn · Reflect · Grow',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Responsive.height(context, 20)),
          ],
        ),
      ),
    );
  }

  // ==================== USER SUMMARY ====================
  Widget _buildUserSummary(BuildContext context, bool isDark) {
    final user = dummyUser;
    final color = Color(int.parse(user.avatarColor.replaceFirst('#', 'FF'), radix: 16));

    return Container(
      padding: EdgeInsets.all(Responsive.padding(context, 16)),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(isDark ? 0.1 : 0.05),
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
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 22),
                  color: color,
                  fontWeight: FontWeight.bold,
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
                  user.name,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 16),
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.white : AppColors.textPrimary,
                  ),
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
                    color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.edit,
            size: Responsive.width(context, 20),
            color: AppColors.emerald,
          ),
        ],
      ),
    );
  }

  // ==================== SETTINGS SECTION ====================
  Widget _buildSettingsSection(BuildContext context, bool isDark, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: Responsive.height(context, 8)),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(isDark ? 0.1 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  // ==================== SETTINGS ITEM BUILDER ====================
  Widget _buildSettingsItem(
      BuildContext context,
      bool isDark,
      IconData icon,
      String title,
      String subtitle,
      VoidCallback onTap, {
        bool showArrow = true,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.padding(context, 16),
          vertical: Responsive.padding(context, 14),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: Responsive.width(context, 22),
              color: AppColors.emerald,
            ),
            SizedBox(width: Responsive.padding(context, 14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.white : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: Responsive.width(context, 14),
                color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
              ),
          ],
        ),
      ),
    );
  }

  // ==================== LANGUAGE SETTING (Placeholder) ====================
  Widget _buildLanguageSetting(BuildContext context, bool isDark) {
    return _buildSettingsItem(
      context,
      isDark,
      Icons.language,
      'Language',
      'English',
          () {
        _showComingSoonDialog(context, isDark, 'Language Settings');
      },
    );
  }

  // ==================== THEME SETTING (Working) ====================
  Widget _buildThemeSetting(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => _showThemeDialog(context, isDark),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.padding(context, 16),
          vertical: Responsive.padding(context, 14),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.brightness_6,
              size: Responsive.width(context, 22),
              color: AppColors.emerald,
            ),
            SizedBox(width: Responsive.padding(context, 14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.white : AppColors.textPrimary,
                    ),
                  ),
                  Obx(() => Text(
                    _themeService.getCurrentThemeName(),
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                    ),
                  )),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Responsive.width(context, 14),
              color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  // ==================== FONT SIZE SETTING (Placeholder) ====================
  Widget _buildFontSizeSetting(BuildContext context, bool isDark) {
    return _buildSettingsItem(
      context,
      isDark,
      Icons.text_fields,
      'Font Size',
      'Medium',
          () {
        _showComingSoonDialog(context, isDark, 'Font Size Settings');
      },
    );
  }

  // ==================== AUDIO SETTING (Placeholder) ====================
  Widget _buildAudioSetting(BuildContext context, bool isDark) {
    return _buildSettingsItem(
      context,
      isDark,
      Icons.volume_up,
      'Audio Settings',
      'Reciter: Default',
          () {
        _showComingSoonDialog(context, isDark, 'Audio Settings');
      },
    );
  }

  // ==================== TRANSLATION SETTING (Placeholder) ====================
  Widget _buildTranslationSetting(BuildContext context, bool isDark) {
    return _buildSettingsItem(
      context,
      isDark,
      Icons.translate,
      'Translation Language',
      'English',
          () {
        _showComingSoonDialog(context, isDark, 'Translation Language Settings');
      },
    );
  }

  // ==================== NOTIFICATIONS SETTING (Placeholder) ====================
  Widget _buildNotificationsSetting(BuildContext context, bool isDark) {
    return _buildSettingsItem(
      context,
      isDark,
      Icons.notifications,
      'Notifications',
      'On',
          () {
        _showComingSoonDialog(context, isDark, 'Notification Settings');
      },
    );
  }

  // ==================== DOWNLOADS SETTING (Placeholder) ====================
  Widget _buildDownloadsSetting(BuildContext context, bool isDark) {
    return _buildSettingsItem(
      context,
      isDark,
      Icons.cloud_download,
      'Downloaded Content',
      '12 items',
          () {
        _showComingSoonDialog(context, isDark, 'Downloaded Content');
      },
    );
  }

  // ==================== ABOUT SETTING ====================
  Widget _buildAboutSetting(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => _showAboutDialog(context, isDark),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.padding(context, 16),
          vertical: Responsive.padding(context, 14),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              size: Responsive.width(context, 22),
              color: AppColors.emerald,
            ),
            SizedBox(width: Responsive.padding(context, 14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.white : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'Noor Madrassa v1.0.0',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Responsive.width(context, 14),
              color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  // ==================== THEME DIALOG (Working) ====================
  void _showThemeDialog(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(Responsive.padding(context, 20)),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Theme',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.white : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              ..._themeService.getAvailableThemes().map((theme) {
                return Obx(() => ListTile(
                  leading: Icon(
                    _themeService.currentTheme.value == theme['code']
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: _themeService.currentTheme.value == theme['code']
                        ? AppColors.emerald
                        : (isDark ? Colors.grey.shade400 : AppColors.textSecondary),
                  ),
                  title: Text(
                    theme['name'] ?? '',
                    style: TextStyle(
                      color: isDark ? AppColors.white : AppColors.textPrimary,
                    ),
                  ),
                  onTap: () {
                    _themeService.changeTheme(theme['code']!);
                    Navigator.pop(context);
                    setState(() {});
                  },
                ));
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  // ==================== ABOUT DIALOG ====================
  void _showAboutDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isDark ? AppColors.darkCard : AppColors.white,
          title: Text(
            'Noor Madrassa',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? AppColors.white : AppColors.textPrimary,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.menu_book,
                size: 60,
                color: AppColors.emerald,
              ),
              const SizedBox(height: 16),
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.white : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Learn · Reflect · Grow',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'An Islamic learning companion for Madrassa students and general users.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close',
                style: TextStyle(
                  color: AppColors.emerald,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==================== COMING SOON DIALOG ====================
  void _showComingSoonDialog(BuildContext context, bool isDark, String featureName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isDark ? AppColors.darkCard : AppColors.white,
          title: Text(
            'Coming Soon',
            style: TextStyle(
              color: isDark ? AppColors.white : AppColors.textPrimary,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.construction,
                size: 50,
                color: AppColors.islamicGold,
              ),
              const SizedBox(height: 16),
              Text(
                featureName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.white : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This feature will be available in the next update.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Got it',
                style: TextStyle(
                  color: AppColors.emerald,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}