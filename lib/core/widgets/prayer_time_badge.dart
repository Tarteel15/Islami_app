import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PrayerTimeBadge extends StatelessWidget {
  final String title;
  final String time;
  final String period;
  final bool isActive;

  const PrayerTimeBadge({
    super.key,
    required this.title,
    required this.time,
    required this.period,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? null : AppColors.black.withOpacity(0.35),
        gradient: isActive ? AppColors.activeBadgeGradient : null,
        borderRadius: BorderRadius.circular(16),
        border: isActive ? Border.all(color: AppColors.gold.withOpacity(0.6), width: 1.2) : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(color: AppColors.white, fontSize: 11, fontFamily: 'Janna'),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Janna',
            ),
          ),
          Text(
            period,
            style: const TextStyle(color: AppColors.textGray, fontSize: 10, fontFamily: 'Janna'),
          ),
        ],
      ),
    );
  }
}