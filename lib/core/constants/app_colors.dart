import 'package:flutter/material.dart';

class AppColors {
  static const Color black = Color(0xFF202020);

  static const Color gold = Color(0xFFE2BE7F);

  static const Color white = Color(0xFFFFFFFF);

  static const Color darkGold = Color(0xFFB19054);

  static const Color surfaceCard = Color(0xFF2A2A2A);

  static const Color textGray = Color(0xFF8E8E93);

  
  static const LinearGradient mainBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF2B2B2B),
      Color(0xFF202020),
      Color(0xFF151515),
    ],
  );

  static const LinearGradient goldCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE2BE7F),
      Color(0xFFB19054),
    ],
  );

  static const LinearGradient activeBadgeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF3E3B33),
      Color(0xFF202020),
    ],
  );
}