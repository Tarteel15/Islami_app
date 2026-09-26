import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/bg_wrapper.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  int _selectedTab = 0; // 0 = Radio, 1 = Reciters

  final List<String> _radioStations = [
    'Radio Ibrahim Al-Akdar',
    'Radio Al-Qaria Yassen',
    'Radio Ahmed Al-trabulsi',
    'Radio Addokali Mohammad Alalim',
  ];

  final List<String> _recitersList = [
    'Ibrahim Al-Akdar',
    'Akram Alalaqmi',
    'Majed Al-Enezi',
    'Malik shaibat Alhamed',
  ];

  @override
  Widget build(BuildContext context) {
    final currentList = _selectedTab == 0 ? _radioStations : _recitersList;

    return BgWrapper(
      // خلفية شاشة الراديو المخصصة
      backgroundImage: 'assets/images/silhouette-woman-reading-quran.png',
      child: Column(
        children: [
          // زر التبديل بين Radio و Reciters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.surfaceCard.withOpacity(0.8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedTab == 0 ? AppColors.gold : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Radio',
                          style: TextStyle(
                            fontFamily: 'Janna',
                            fontWeight: FontWeight.bold,
                            color: _selectedTab == 0 ? AppColors.black : AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedTab == 1 ? AppColors.gold : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Reciters',
                          style: TextStyle(
                            fontFamily: 'Janna',
                            fontWeight: FontWeight.bold,
                            color: _selectedTab == 1 ? AppColors.black : AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // قائمة الكروت
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: currentList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final isWaveform = index == 1; // الكارت الثاني يحتوي على خطوط الموجات الصوتية
                return Container(
                  height: 135,
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Stack(
                      children: [
                        // زخرفة المساجد في أسفل كل كارت
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Opacity(
                            opacity: 0.35,
                            child: Image.asset(
                              'assets/images/Mosque-02.png',
                              fit: BoxFit.cover,
                              height: 70,
                              errorBuilder: (_, __, ___) => const SizedBox(),
                            ),
                          ),
                        ),

                        // محتوى الكارت
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              currentList[index],
                              style: const TextStyle(
                                fontFamily: 'Janna',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isWaveform ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                  size: 42,
                                  color: AppColors.black,
                                ),
                                const SizedBox(width: 24),
                                Icon(
                                  isWaveform ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                                  size: 26,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}