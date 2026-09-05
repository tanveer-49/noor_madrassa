// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:noor_madrassa/app/app_colors.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          'assets/images/splash_logo.png',
          fit: BoxFit.cover,
          alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) {

            return Container(
              color: AppColors.warmCream,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.emerald,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.menu_book,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Noor Madrassa',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepForest,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Learn · Reflect · Grow',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const CircularProgressIndicator(
                      color: AppColors.emerald,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}