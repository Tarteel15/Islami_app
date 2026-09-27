import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../quran/quran_screen.dart';
import '../hadeth/hadeth_screen.dart';
import '../sebha/sebha_screen.dart';
import '../radio/radio_screen.dart';
import '../time/time_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    QuranScreen(),
    HadethScreen(),
    SebhaScreen(),
    RadioScreen(),
    TimeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: AppColors.gold,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCustomNavItem(
              imagePath: 'assets/images/quran.png',
              label: 'Quran',
              index: 0,
              fallbackIcon: Icons.menu_book_rounded,
            ),

            _buildCustomNavItem(
              imagePath: 'assets/images/book-album-svgrepo-com 1.png',
              label: 'Hadith',
              index: 1,
              fallbackIcon: Icons.book_outlined,
            ),

            _buildCustomNavItem(
              imagePath: 'assets/images/necklace-islam-svgrepo-com 1.png',
              label: 'Sebha',
              index: 2,
              fallbackIcon: Icons.fingerprint,
            ),

            _buildCustomNavItem(
              imagePath: 'assets/images/radio-svgrepo-com 1.png',
              label: 'Radio',
              index: 3,
              fallbackIcon: Icons.radio,
            ),

            _buildCustomNavItem(
              imagePath: 'assets/images/Vector.png',
              label: 'Time',
              index: 4,
              fallbackIcon: Icons.access_time_filled,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomNavItem({
    required String imagePath,
    required String label,
    required int index,
    required IconData fallbackIcon,
  }) {
    final bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF202020).withOpacity(0.65)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 24,
              height: 24,
              color: isSelected ? Colors.white : AppColors.black,
              errorBuilder: (_, __, ___) => Icon(
                fallbackIcon,
                size: 24,
                color: isSelected ? Colors.white : AppColors.black,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Janna',
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}