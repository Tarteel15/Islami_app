import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class BgWrapper extends StatelessWidget {
  final Widget child;
  final bool showHeader;
  final String? backgroundImage;

  const BgWrapper({
    super.key,
    required this.child,
    this.showHeader = true,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (backgroundImage != null)
            Image.asset(
              backgroundImage!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.mainBackgroundGradient,
                ),
              ),
            )
          else
            Container(
              decoration: const BoxDecoration(
                gradient: AppColors.mainBackgroundGradient,
              ),
            ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/Mosque-01.png',
                fit: BoxFit.contain,
                height: 180,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                if (showHeader) ...[
                  const SizedBox(height: 8),
                  Center(
                    child: Image.asset(
                      'assets/images/Islami.png',
                      width: 170,
                      height: 79,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}