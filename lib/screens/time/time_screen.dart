import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/bg_wrapper.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BgWrapper(
      backgroundImage: 'assets/images/timebg.png',
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // كارت مواقيت الصلاة المنحني 390x301
            Center(
              child: SizedBox(
                width: 390,
                height: 301,
                child: Stack(
                  children: [
                    Container(
                      width: 390,
                      height: 301,
                      decoration: BoxDecoration(
                        color: const Color(0xFF856B3F),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.only(left: 22, right: 22, top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '16 Jul,\n2024',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Janna',
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            '09 Muh,\n1446',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Janna',
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned.fill(
                      child: ClipPath(
                        clipper: PrayCardCustomClipper(),
                        child: Container(
                          color: AppColors.gold,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                'Pray Time',
                                style: TextStyle(
                                  color: Color(0xFF6B5328),
                                  fontFamily: 'Janna',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Text(
                                'Tuesday',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontFamily: 'Janna',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),

                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    _buildPrayerItem('Sunrise', '04:04', 'AM', false),
                                    _buildPrayerItem('Dhuhr', '01:01', 'PM', false),
                                    _buildPrayerItem('ASR', '04:38', 'PM', true),
                                    _buildPrayerItem('Maghrib', '07:57', 'PM', false),
                                    _buildPrayerItem('Isha', '09:20', 'PM', false),
                                  ],
                                ),
                              ),

                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Next Pray - 02:32',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontFamily: 'Janna',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.volume_off_rounded, color: AppColors.black, size: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                'Azkar',
                style: TextStyle(
                  fontFamily: 'Janna',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _buildAzkarCard('Evening Azkar', 'assets/images/evening_azkar.png'),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildAzkarCard('Morning Azkar', 'assets/images/morning_azkar.png'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _buildPrayerItem(String title, String time, String period, bool isActive) {
    return Container(
      width: isActive ? 100 : 76,
      height: isActive ? 130 : 110,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isActive
              ? [const Color(0xFF4A4234), const Color(0xFF28231C)]
              : [const Color(0xFF6B583E), const Color(0xFF3E3322)],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 11, fontFamily: 'Janna')),
          const SizedBox(height: 2),
          Text(
            time,
            style: TextStyle(
              color: Colors.white,
              fontSize: isActive ? 22 : 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Janna',
            ),
          ),
          Text(period, style: const TextStyle(color: Colors.white70, fontSize: 10, fontFamily: 'Janna')),
        ],
      ),
    );
  }

  static Widget _buildAzkarCard(String title, String imagePath) {
    return Container(
      height: 245,
      decoration: BoxDecoration(
        color: const Color(0xFF202020).withOpacity(0.85),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.gold.withOpacity(0.5), width: 1.5),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(Icons.nights_stay, color: AppColors.gold, size: 70),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.white,
              fontFamily: 'Janna',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class PrayCardCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path.moveTo(0, 68);
    path.quadraticBezierTo(w * 0.23, 68, w * 0.28, 28);
    path.quadraticBezierTo(w * 0.32, 0, w * 0.44, 0);
    path.lineTo(w * 0.56, 0);
    path.quadraticBezierTo(w * 0.68, 0, w * 0.72, 28);
    path.quadraticBezierTo(w * 0.77, 68, w, 68);
    path.lineTo(w, h - 35);
    path.quadraticBezierTo(w, h, w - 35, h);
    path.lineTo(35, h);
    path.quadraticBezierTo(0, h, 0, h - 35);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}