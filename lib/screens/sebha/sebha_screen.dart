import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  int _counter = 0;
  int _azkarIndex = 0;
  double _angle = 0.0;

  final List<String> _azkarList = [
    'سبحان الله',
    'الله أكبر',
    'الحمد لله',
    'لا إله إلا الله',
    'لا حول ولا قوة إلا بالله',
  ];

  void _onSebhaTap() {
    setState(() {
      _counter++;
      _angle += (2 * math.pi) / 30;

      if (_counter == 30) {
        _counter = 0;
        _azkarIndex = (_azkarIndex + 1) % _azkarList.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/sebhabg.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              decoration: const BoxDecoration(
                gradient: AppColors.mainBackgroundGradient,
              ),
            ),
          ),

          // 2. طبقة تعتيم خفيفة
          Container(color: Colors.black.withOpacity(0.35)),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 14),

                SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // رسمة المسجد في الخلفية
                      Opacity(
                        opacity: 0.35,
                        child: Image.asset(
                          'assets/images/Mosque-01.png',
                          height: 140,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const SizedBox(),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        child: Image.asset(
                          'assets/images/Islami.png',
                          width: 170,
                          height: 79,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'سَبِّحِ اسْمَ رَبِّكَ الأَعْلَى',
                  style: TextStyle(
                    fontFamily: 'Janna',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const Spacer(),

                GestureDetector(
                  onTap: _onSebhaTap,
                  child: SizedBox(
                    width: 320,
                    height: 360,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedRotation(
                          turns: _angle / (2 * math.pi),
                          duration: const Duration(milliseconds: 230),
                          curve: Curves.easeOut,
                          child: SizedBox(
                            width: 290,
                            height: 340,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Positioned(
                                  top: 0,
                                  child: Image.asset(
                                    'assets/images/head.png',
                                    height: 70,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) =>
                                        const SizedBox(),
                                  ),
                                ),
                                Positioned(
                                  top: 42,
                                  child: Image.asset(
                                    'assets/images/body.png',
                                    width: 260,
                                    height: 260,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 250,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.gold,
                                          width: 4,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          top: 150,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _azkarList[_azkarIndex],
                                style: const TextStyle(
                                  fontFamily: 'Janna',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$_counter',
                                style: const TextStyle(
                                  fontFamily: 'Janna',
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
