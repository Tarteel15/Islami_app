import 'package:flutter/material.dart';

class AppColors {
  // 1. Black الأساسي (حسب التحديد)
  static const Color black = Color(0xFF202020);

  // 2. Gold الأساسي (حسب التحديد)
  static const Color gold = Color(0xFFE2BE7F);

  // 3. White الأساسي (حسب التحديد)
  static const Color white = Color(0xFFFFFFFF);

  // 4. Dark Gold (المستخدم في تدرج البطاقات والأزرار المتباينة)
  static const Color darkGold = Color(0xFFB19054);

  // 5. Surface Black / Card Dark (لون خلفية الكروت والحاويات غير الشفافة)
  static const Color surfaceCard = Color(0xFF2A2A2A);

  // 6. Text Muted / Gray (للنصوص الثانوية وتفاصيل الآيات ومؤشرات البايجر)
  static const Color textGray = Color(0xFF8E8E93);

  // --- التدرجات (Gradients) كما في الصور ---
  
  // تدرج الخلفية العامة (من الأسود 0xFF202020 وتلاشيه إلى أغمق أسفل الشاشة)
  static const LinearGradient mainBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF2B2B2B),
      Color(0xFF202020),
      Color(0xFF151515),
    ],
  );

  // تدرج كارت مواقيت الصلاة (Time Screen) الذهبي المتدرج
  static const LinearGradient goldCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE2BE7F),
      Color(0xFFB19054),
    ],
  );

  // تدرج عناصر وقت الصلاة المفعلة (ASR Badge)
  static const LinearGradient activeBadgeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF3E3B33),
      Color(0xFF202020),
    ],
  );
}