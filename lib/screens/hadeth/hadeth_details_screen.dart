import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/hadeth_model.dart';

class HadethDetailsScreen extends StatelessWidget {
  final HadethModel hadeth;

  const HadethDetailsScreen({super.key, required this.hadeth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text(
          hadeth.title,
          style: const TextStyle(
            color: AppColors.gold,
            fontFamily: 'Janna',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.gold),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.mainBackgroundGradient,
        ),
        child: Stack(
          children: [
            // المساجد أسفل شاشة الديتيلز
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/Mosque-02.png',
                fit: BoxFit.fill,
                height: 110,
              ),
            ),

            // محتوى تفاصيل الحديث
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
              child: Column(
                children: [
                  // الـ Corners حول عنوان الحديث
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/left_corner.png',
                        width: 70,
                        height: 70,
                        fit: BoxFit.contain,
                      ),
                      Expanded(
                        child: Text(
                          hadeth.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Janna',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gold,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/right_corner.png',
                        width: 70,
                        height: 70,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // نص الحديث كامل باللون الذهبي وقابل للـ Scroll
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 110),
                      child: Text(
                        hadeth.content,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontFamily: 'Janna',
                          color: AppColors.gold, // لون الحديث دهبي حسب المطلوب
                          fontSize: 18,
                          height: 2.1,
                          fontWeight: FontWeight.w600,
                        ),
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
}