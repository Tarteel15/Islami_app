import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../core/constants/app_colors.dart';
import '../../models/sura_model.dart';

class SuraDetailsScreen extends StatefulWidget {
  final SuraModel sura;

  const SuraDetailsScreen({super.key, required this.sura});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  String _suraContent = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSuraVerses();
  }

  Future<void> _loadSuraVerses() async {
    String content = '';
    
    List<String> pathsToTry = [
      'assets/suras/${widget.sura.index}.txt',
      'assets/suras/${widget.sura.index.toString().padLeft(3, '0')}.txt',
      'assets/quran/${widget.sura.index}.txt',
    ];

    for (String path in pathsToTry) {
      try {
        String data = await rootBundle.loadString(path);
        List<String> lines = data.trim().split('\n');
        
        StringBuffer buffer = StringBuffer();
        for (int i = 0; i < lines.length; i++) {
          String line = lines[i].trim();
          if (line.isNotEmpty) {
            buffer.write('$line [${i + 1}] ');
          }
        }
        content = buffer.toString().trim();
        if (content.isNotEmpty) break;
      } catch (_) {}
    }

    if (content.isEmpty) {
      if (widget.sura.index == 1) {
        content =
            'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ [1] الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ [2] الرَّحْمَٰنِ الرَّحِيمِ [3] مَالِكِ يَوْمِ الدِّينِ [4] إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ [5] اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ [6] صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ [7]';
      } else {
        content = 'سورة ${widget.sura.arabicName}';
      }
    }

    if (mounted) {
      setState(() {
        _suraContent = content;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.sura.englishName,
          style: const TextStyle(
            color: AppColors.gold,
            fontFamily: 'Janna',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.gold),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.mainBackgroundGradient,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/Mosque-02.png',
              fit: BoxFit.fill,
              height: 100,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.gold))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 90,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              left: 6,
                              top: 0,
                              child: Image.asset(
                                'assets/images/left_corner.png',
                                width: 85,
                                height: 85,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const SizedBox(),
                              ),
                            ),
                            Text(
                              widget.sura.arabicName,
                              style: const TextStyle(
                                color: AppColors.gold,
                                fontFamily: 'Janna',
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Positioned(
                              right: 6,
                              top: 0,
                              child: Image.asset(
                                'assets/images/right_corner.png',
                                width: 85,
                                height: 85,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 110, left: 10, right: 10),
                          child: Text(
                            _suraContent,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontFamily: 'Janna',
                              color: AppColors.gold,
                              fontSize: 20,
                              height: 2.3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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