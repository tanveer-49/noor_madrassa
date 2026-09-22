// lib/screens/profile/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/user_data.dart';
import 'package:noor_madrassa/services/theme_service.dart';
import 'package:noor_madrassa/services/font_size_service.dart';
import 'package:noor_madrassa/services/language_service.dart';
import 'package:noor_madrassa/screens/notifications/notification_settings_screen.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ThemeService _themeService = Get.find();
  final FontSizeService _fontSizeService = Get.find();
  final LanguageService _languageService = Get.find();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 20),
            color: context.textColor,
          ),
        ),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        toolbarHeight: Responsive.height(context, 56),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.padding(context, 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Summary
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
              // Translation Language
              _buildSettingsItem(
                context,
                isDark,
                Icons.translate,
                'Translation Language',
                'English',
                    () => _showComingSoon(context, isDark, 'Translation Language'),
              ),

              _buildSettingsItem(
                context,
                isDark,
                Icons.notifications,
                'Notifications',
                'Manage notification preferences',
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationSettingsScreen(),
                    ),
                  );
                },
              ),
            ]),

            SizedBox(height: Responsive.height(context, 16)),

            // Support Section
            _buildSettingsSection(context, isDark, 'Support', [
              _buildSettingsItem(
                context,
                isDark,
                Icons.cloud_download,
                'Downloaded Content',
                '12 items',
                    () => _showComingSoon(context, isDark, 'Downloaded Content'),
              ),
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
                      color: context.textColor,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 4)),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: context.textSecondaryColor,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 4)),
                  Text(
                    'Learn . Reflect . Grow',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: context.textSecondaryColor,
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

  Widget _buildUserSummary(BuildContext context, bool isDark) {
    final user = dummyUser;
    final color = Color(int.parse(user.avatarColor.replaceFirst('#', 'FF'), radix: 16));

    return Container(
      padding: EdgeInsets.all(Responsive.padding(context, 16)),
      decoration: BoxDecoration(
        color: context.cardColor,
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
                    color: context.textColor,
                  ),
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
                    color: context.textSecondaryColor,
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

  Widget _buildSettingsSection(
      BuildContext context,
      bool isDark,
      String title,
      List<Widget> children,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 14),
            fontWeight: FontWeight.w600,
            color: context.textSecondaryColor,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: Responsive.height(context, 8)),
        Container(
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(isDark ? 0.1 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(
      BuildContext context,
      bool isDark,
      IconData icon,
      String title,
      String subtitle,
      VoidCallback onTap,
      ) {
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
                      color: context.textColor,
                    ),
                  ),
                  Text(
                    subtitle,
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
      ),
    );
  }

  Widget _buildLanguageSetting(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => _showLanguageDialog(context, isDark),
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
              Icons.language,
              size: Responsive.width(context, 22),
              color: AppColors.emerald,
            ),
            SizedBox(width: Responsive.padding(context, 14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Language',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      fontWeight: FontWeight.w500,
                      color: context.textColor,
                    ),
                  ),
                  Obx(() => Text(
                    _languageService.getCurrentLanguageName(),
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: context.textSecondaryColor,
                    ),
                  )),
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
                      color: context.textColor,
                    ),
                  ),
                  Obx(() => Text(
                    _themeService.getCurrentThemeName(),
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: context.textSecondaryColor,
                    ),
                  )),
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

  Widget _buildFontSizeSetting(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => _showFontSizeDialog(context, isDark),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.padding(context, 16),
          vertical: Responsive.padding(context, 14),
        ),
        child: Row(
          children: [
            Icon(
              Icons.text_fields,
              size: Responsive.width(context, 22),
              color: AppColors.emerald,
            ),
            SizedBox(width: Responsive.padding(context, 14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Font Size',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 14),
                      fontWeight: FontWeight.w500,
                      color: context.textColor,
                    ),
                  ),
                  Obx(() => Text(
                    _fontSizeService.getCurrentFontSizeName(),
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 12),
                      color: context.textSecondaryColor,
                    ),
                  )),
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
                      color: context.textColor,
                    ),
                  ),
                  Text(
                    'Noor Madrassa v1.0.0',
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
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(Responsive.padding(context, 20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Language',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 18),
                  fontWeight: FontWeight.bold,
                  color: context.textColor,
                ),
              ),
              const SizedBox(height: 16),
              ..._languageService.getAvailableLanguages().map((lang) {
                return Obx(() => ListTile(
                  leading: Icon(
                    _languageService.currentLanguage.value == lang['code']
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: _languageService.currentLanguage.value == lang['code']
                        ? AppColors.emerald
                        : context.textSecondaryColor,
                  ),
                  title: Text(
                    lang['native'] ?? '',
                    style: TextStyle(
                      color: context.textColor,
                      fontWeight: _languageService.currentLanguage.value == lang['code']
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  subtitle: Text(
                    lang['name'] ?? '',
                    style: TextStyle(
                      color: context.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                  onTap: () {
                    _languageService.changeLanguage(lang['code']!);
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

  void _showThemeDialog(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(Responsive.padding(context, 20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Theme',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 18),
                  fontWeight: FontWeight.bold,
                  color: context.textColor,
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
                        : context.textSecondaryColor,
                  ),
                  title: Text(
                    theme['name'] ?? '',
                    style: TextStyle(
                      color: context.textColor,
                      fontWeight: _themeService.currentTheme.value == theme['code']
                          ? FontWeight.bold
                          : FontWeight.normal,
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

  void _showFontSizeDialog(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(Responsive.padding(context, 20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Font Size',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 18),
                  fontWeight: FontWeight.bold,
                  color: context.textColor,
                ),
              ),
              const SizedBox(height: 16),
              ..._fontSizeService.getAvailableFontSizes().map((size) {
                return Obx(() => ListTile(
                  leading: Icon(
                    _fontSizeService.currentFontSize.value == size['code']
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: _fontSizeService.currentFontSize.value == size['code']
                        ? AppColors.emerald
                        : context.textSecondaryColor,
                  ),
                  title: Text(
                    size['name'] ?? '',
                    style: TextStyle(
                      color: context.textColor,
                      fontWeight: _fontSizeService.currentFontSize.value == size['code']
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  trailing: Text(
                    size['size'] ?? '',
                    style: TextStyle(
                      color: context.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                  onTap: () {
                    _fontSizeService.changeFontSize(size['code']!);
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

  void _showAboutDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Noor Madrassa',
            textAlign: TextAlign.center,
            style: TextStyle(color: context.textColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.menu_book, size: 60, color: AppColors.emerald),
              const SizedBox(height: 16),
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: context.textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Learn . Reflect . Grow',
                textAlign: TextAlign.center,
                style: TextStyle(color: context.textSecondaryColor),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'An Islamic learning companion for Madrassa students and general users.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.textSecondaryColor,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close', style: TextStyle(color: AppColors.emerald)),
            ),
          ],
        );
      },
    );
  }

  void _showComingSoon(BuildContext context, bool isDark, String feature) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Coming Soon',
            style: TextStyle(color: context.textColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.construction, size: 50, color: AppColors.islamicGold),
              const SizedBox(height: 16),
              Text(
                feature,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: context.textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This feature will be available in the next update.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: context.textSecondaryColor,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it', style: TextStyle(color: AppColors.emerald)),
            ),
          ],
        );
      },
    );
  }
}