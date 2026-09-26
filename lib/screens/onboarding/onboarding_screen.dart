import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/constants/app_colors.dart';
import '../main_layout/main_layout_screen.dart';

class OnboardingItem {
  final String image;
  final String title;
  final String desc;

  const OnboardingItem({
    required this.image,
    required this.title,
    required this.desc,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // الخمس صفحات كاملة
  final List<OnboardingItem> _pages = const [
    OnboardingItem(
      image: 'assets/images/welcome.png', // أول صفحة تم تغييرها لـ welcome.png
      title: 'Welcome To Islami',
      desc: '',
    ),
    OnboardingItem(
      image: 'assets/images/kabba.png',
      title: 'Welcome To Islami',
      desc: 'We Are Very Excited To Have You In Our Community',
    ),
    OnboardingItem(
      image: 'assets/images/onb3.png',
      title: 'Reading the Quran',
      desc: 'Read, and your Lord is the Most Generous',
    ),
    OnboardingItem(
      image: 'assets/images/bearish.png',
      title: 'Bearish',
      desc: 'Praise the name of your Lord, the Most High',
    ),
    OnboardingItem(
      image: 'assets/images/radio.png',
      title: 'Holy Quran Radio',
      desc: 'You can listen to the Holy Quran Radio through the application for free and easily',
    ),
  ];

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainLayoutScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // الخلفية الداكنة المتدرجة
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.mainBackgroundGradient,
            ),
          ),

          // المحتوى
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),

                // هيدر المسجد وكلمة Islami بنفس تصميم باقي شاشات التطبيق
                SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: 0.7,
                        child: Image.asset(
                          'assets/images/Mosque-01.png',
                          height: 110,
                          width: 280,
                          fit: BoxFit.fitWidth,
                          errorBuilder: (_, __, ___) => const SizedBox(),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        child: Image.asset(
                          'assets/images/Islami.png',
                          width: 170,
                          height: 75,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // عرض الـ 5 صفحات
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final item = _pages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // صورة الصفحة
                            Expanded(
                              flex: 5,
                              child: Center(
                                child: Image.asset(
                                  item.image,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.image_not_supported,
                                    size: 90,
                                    color: AppColors.gold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28), // مسافة مناسبة لإنزال النص

                            // عنوان الصفحة باللون الذهبي
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.gold,
                                fontFamily: 'Janna',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // وصف الصفحة باللون الذهبي المطابق للعنوان
                            Text(
                              item.desc,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.gold,
                                fontFamily: 'Janna',
                                fontSize: 18,
                                height: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const Spacer(flex: 1),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // أزرار التنقل ومؤشر الـ 5 صفحات
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // زر Back
                      _currentIndex > 0
                          ? TextButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontFamily: 'Janna',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const SizedBox(width: 60),

                      // مؤشر النقاط لـ 5 صفحات
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: _pages.length,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          expansionFactor: 3,
                          activeDotColor: AppColors.gold,
                          dotColor: Colors.grey,
                        ),
                      ),

                      // زر Next أو Finish
                      TextButton(
                        onPressed: () {
                          if (_currentIndex < _pages.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            _finishOnboarding();
                          }
                        },
                        child: Text(
                          _currentIndex == _pages.length - 1 ? 'Finish' : 'Next',
                          style: const TextStyle(
                            color: AppColors.gold,
                            fontFamily: 'Janna',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}