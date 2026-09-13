// lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'package:noor_madrassa/data/onboarding_data.dart';
import 'package:noor_madrassa/models/onboarding_model.dart';
import 'package:noor_madrassa/screens/home_screen.dart';
import 'package:noor_madrassa/utils/responsive.dart';
import 'package:noor_madrassa/utils/theme_extensions.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button (Top Right)
            Padding(
              padding: EdgeInsets.all(Responsive.padding(context, 16)),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: _navigateToHome,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.padding(context, 16),
                      vertical: Responsive.padding(context, 8),
                    ),
                    decoration: BoxDecoration(
                      color: context.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                      ),
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: context.textSecondaryColor,
                        fontSize: Responsive.fontSize(context, 14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // PageView with 3 slides
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingSlide(context, isDark, index);
                },
              ),
            ),

            // Bottom: Dots + Next/Get Started Button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.padding(context, 24),
                vertical: Responsive.padding(context, 20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dot Indicators
                  _buildDots(context),

                  // Next / Get Started Button
                  GestureDetector(
                    onTap: () {
                      if (_currentPage == onboardingData.length - 1) {
                        _navigateToHome();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOutCubic,
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.padding(context, 28),
                        vertical: Responsive.padding(context, 14),
                      ),
                      decoration: BoxDecoration(
                        gradient: AppGradients.primaryGradient,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.emerald.withOpacity(0.4),
                            blurRadius: 15,
                            spreadRadius: 2,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _currentPage == onboardingData.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Responsive.fontSize(context, 15),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentPage == onboardingData.length - 1
                                ? Icons.check_circle
                                : Icons.arrow_forward,
                            color: Colors.white,
                            size: Responsive.width(context, 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingSlide(BuildContext context, bool isDark, int index) {
    final item = onboardingData[index];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 24)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ✅ Premium Icon Container - Gradient with Islamic Pattern
          _buildPremiumIcon(context, item),

          SizedBox(height: Responsive.height(context, 40)),

          // ✅ Tagline Badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.padding(context, 16),
              vertical: Responsive.padding(context, 6),
            ),
            decoration: BoxDecoration(
              color: AppColors.islamicGold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.islamicGold.withOpacity(0.3),
              ),
            ),
            child: Text(
              item.tagline,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, 12),
                color: AppColors.islamicGold,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),

          SizedBox(height: Responsive.height(context, 20)),

          // ✅ Title - Premium Typography
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 26),
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.white : AppColors.deepForest,
              height: 1.3,
              letterSpacing: -0.5,
            ),
          ),

          SizedBox(height: Responsive.height(context, 16)),

          // ✅ Description
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 15),
              color: isDark ? Colors.grey.shade400 : AppColors.textSecondary,
              height: 1.6,
            ),
          ),

          SizedBox(height: Responsive.height(context, 30)),

          // ✅ Islamic Divider
          _buildIslamicDivider(context),
        ],
      ),
    );
  }

  // ✅ Premium Icon with Gradient + Decorative Circles
  Widget _buildPremiumIcon(BuildContext context, OnboardingItem item) {
    final size = Responsive.width(context, 160);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer Ring 1
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.emerald.withOpacity(0.1),
                width: 1.5,
              ),
            ),
          ),

          // Outer Ring 2
          Container(
            width: size * 0.85,
            height: size * 0.85,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.emerald.withOpacity(0.15),
                width: 1.5,
              ),
            ),
          ),

          // Gradient Circle with Icon
          Container(
            width: size * 0.7,
            height: size * 0.7,
            decoration: BoxDecoration(
              gradient: AppGradients.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.emerald.withOpacity(0.4),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Icon(
              item.icon,
              size: size * 0.3,
              color: Colors.white,
            ),
          ),

          // Decorative Gold Dot - Top Right
          Positioned(
            top: size * 0.1,
            right: size * 0.1,
            child: Container(
              width: Responsive.width(context, 12),
              height: Responsive.width(context, 12),
              decoration: BoxDecoration(
                color: AppColors.islamicGold,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.islamicGold.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),

          // Decorative Emerald Dot - Bottom Left
          Positioned(
            bottom: size * 0.15,
            left: size * 0.1,
            child: Container(
              width: Responsive.width(context, 8),
              height: Responsive.width(context, 8),
              decoration: BoxDecoration(
                color: AppColors.softEmerald,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Islamic Divider with Ornaments
  Widget _buildIslamicDivider(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: Responsive.width(context, 30),
          height: 1,
          color: AppColors.islamicGold.withOpacity(0.3),
        ),
        SizedBox(width: Responsive.width(context, 8)),
        Container(
          width: Responsive.width(context, 6),
          height: Responsive.width(context, 6),
          decoration: BoxDecoration(
            color: AppColors.islamicGold.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: Responsive.width(context, 8)),
        Container(
          width: Responsive.width(context, 30),
          height: 1,
          color: AppColors.islamicGold.withOpacity(0.3),
        ),
      ],
    );
  }

  // ✅ Premium Dots Indicator
  Widget _buildDots(BuildContext context) {
    return Row(
      children: List.generate(
        onboardingData.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
          margin: EdgeInsets.only(right: Responsive.width(context, 6)),
          width: _currentPage == index
              ? Responsive.width(context, 28)
              : Responsive.width(context, 8),
          height: Responsive.width(context, 8),
          decoration: BoxDecoration(
            gradient: _currentPage == index ? AppGradients.primaryGradient : null,
            color: _currentPage == index
                ? null
                : AppColors.emerald.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}