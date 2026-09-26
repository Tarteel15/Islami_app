import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const CustomSearchField({
    super.key,
    required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: const TextStyle(color: AppColors.white, fontFamily: 'Janna'),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.surfaceCard.withOpacity(0.6),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.textGray,
          fontFamily: 'Janna',
          fontSize: 13,
        ),
        prefixIcon: const Icon(Icons.search, color: AppColors.gold),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gold, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gold, width: 2),
        ),
      ),
    );
  }
}