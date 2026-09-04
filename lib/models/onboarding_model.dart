// lib/models/onboarding_model.dart

import 'package:flutter/material.dart';

class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;
  final String imageAsset;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
    this.imageAsset = '',
  });
}