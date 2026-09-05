// lib/utils/theme_extensions.dart
import 'package:flutter/material.dart';
import '../app/app_colors.dart';

extension ThemeExtension on BuildContext {
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get cardColor => Theme.of(this).cardColor;
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get textColor => Theme.of(this).textTheme.bodyLarge?.color ?? AppColors.textPrimary;
  Color get textSecondaryColor => Theme.of(this).textTheme.bodyMedium?.color ?? AppColors.textSecondary;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}


class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      AppColors.deepForest,
      AppColors.emerald,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient getGradientForCard(BuildContext context, {Color? baseColor}) {
    if (context.isDarkMode) {
      return LinearGradient(
        colors: [
          AppColors.darkCard,
          AppColors.darkCard.withOpacity(0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return const LinearGradient(
      colors: [
        AppColors.deepForest,
        AppColors.emerald,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}