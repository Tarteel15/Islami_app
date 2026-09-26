import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_colors.dart';
import '../../models/sura_model.dart';
import 'sura_details_screen.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  String _searchQuery = '';
  final List<SuraModel> _allSuras = SuraModel.getSurasList();
  List<SuraModel> _recentSuras = [];

  @override
  void initState() {
    super.initState();
    _initRecents();
  }

  void _initRecents() {
    // تعيين سور افتراضية فوراً في البداية حتى لا يكون المكان فارغاً نهائياً
    _recentSuras = [
      _allSuras[20], // Al-Anbiya
      _allSuras[0],  // Al-Fatiha
    ];
    _loadSavedRecents();
  }

  Future<void> _loadSavedRecents() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? recentIndices = prefs.getStringList('recent_suras');

      if (recentIndices != null && recentIndices.isNotEmpty) {
        List<SuraModel> loaded = [];
        for (String indexStr in recentIndices) {
          int idx = int.tryParse(indexStr) ?? 1;
          final match = _allSuras.firstWhere(
            (s) => s.index == idx,
            orElse: () => _allSuras[0],
          );
          if (!loaded.contains(match)) {
            loaded.add(match);
          }
        }
        if (loaded.isNotEmpty && mounted) {
          setState(() {
            _recentSuras = loaded;
          });
        }
      }
    } catch (_) {}
  }

  Future<void> _addSuraToRecent(SuraModel sura) async {
    // تحديث الواجهة فوراً في الـ State
    setState(() {
      _recentSuras.removeWhere((item) => item.index == sura.index);
      _recentSuras.insert(0, sura);
      if (_recentSuras.length > 10) {
        _recentSuras = _recentSuras.sublist(0, 10);
      }
    });

    // حفظ في الـ SharedPreferences
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> indices = _recentSuras.map((s) => '${s.index}').toList();
      await prefs.setStringList('recent_suras', indices);
    } catch (_) {}
  }

  void _openSuraDetails(SuraModel sura) {
    _addSuraToRecent(sura);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuraDetailsScreen(sura: sura),
      ),
    ).then((_) => _loadSavedRecents());
  }

  @override
  Widget build(BuildContext context) {
    // تصفية السور حسب نص البحث
    List<SuraModel> filteredSuras = _allSuras.where((sura) {
      return sura.arabicName.contains(_searchQuery.trim()) ||
          sura.englishName.toLowerCase().contains(_searchQuery.trim().toLowerCase());
    }).toList();

    // السور المعروضة في قسم الـ Most Recently:
    // إذا كان المستخدم يبحث -> نعرض نتائج البحث ككروت بالأعلى كما في فيجما
    // إذا لم يكن يبحث -> نعرض السور التي زارها مؤخراً
    List<SuraModel> displayedRecent = _searchQuery.trim().isNotEmpty
        ? filteredSuras
        : _recentSuras;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. الخلفية
        Image.asset(
          'assets/images/homebg.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            decoration: const BoxDecoration(
              gradient: AppColors.mainBackgroundGradient,
            ),
          ),
        ),

        // 2. طبقة التعتيم
        Container(
          color: Colors.black.withOpacity(0.35),
        ),

        // 3. المحتوى
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),

              // هيدر المسجد وكلمة Islami
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: 0.35,
                      child: Image.asset(
                        'assets/images/Mosque-01.png',
                        height: 120,
                        fit: BoxFit.contain,
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

              const SizedBox(height: 8),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // مربع البحث
                      TextField(
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val;
                          });
                        },
                        style: const TextStyle(color: Colors.white, fontFamily: 'Janna'),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF202020).withOpacity(0.7),
                          hintText: 'Sura Name',
                          hintStyle: const TextStyle(
                            color: AppColors.textGray,
                            fontFamily: 'Janna',
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(Icons.search, color: AppColors.gold),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.gold, width: 1.2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.gold, width: 1.8),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // قسم Most Recently يظهر دائماً ولا يختفي
                      if (displayedRecent.isNotEmpty) ...[
                        const Text(
                          'Most Recently',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Janna',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 125,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: displayedRecent.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              return _buildRecentCard(displayedRecent[index]);
                            },
                          ),
                        ),
                      ],

                      const SizedBox(height: 12),
                      const Text(
                        'Suras List',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Janna',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // قائمة السور
                      Expanded(
                        child: filteredSuras.isEmpty
                            ? const Center(
                                child: Text(
                                  'لا توجد نتائج مطابقة',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontFamily: 'Janna',
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: filteredSuras.length,
                                separatorBuilder: (_, __) => Divider(
                                  color: Colors.white.withOpacity(0.2),
                                  thickness: 1,
                                  indent: 40,
                                  endIndent: 40,
                                ),
                                itemBuilder: (context, index) {
                                  final sura = filteredSuras[index];
                                  return InkWell(
                                    onTap: () => _openSuraDetails(sura),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                                      child: Row(
                                        children: [
                                          // رقم السورة داخل suranum.png
                                          SizedBox(
                                            width: 44,
                                            height: 44,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/suranum.png',
                                                  width: 44,
                                                  height: 44,
                                                  fit: BoxFit.contain,
                                                  errorBuilder: (_, __, ___) => const Icon(
                                                    Icons.star_outline_rounded,
                                                    color: Colors.white,
                                                    size: 40,
                                                  ),
                                                ),
                                                Text(
                                                  '${sura.index}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Janna',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 14),

                                          // اسم السورة بالإنجليزية وعدد الآيات
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  sura.englishName,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Janna',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  sura.versesCount,
                                                  style: const TextStyle(
                                                    color: AppColors.textGray,
                                                    fontFamily: 'Janna',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // اسم السورة بالعربية
                                          Text(
                                            sura.arabicName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Janna',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentCard(SuraModel sura) {
    return GestureDetector(
      onTap: () => _openSuraDetails(sura),
      child: Container(
        width: 255,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    sura.englishName,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontFamily: 'Janna',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sura.arabicName,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontFamily: 'Janna',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sura.versesCount,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontFamily: 'Janna',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/reading.png',
              width: 75,
              height: 75,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.menu_book,
                color: AppColors.black,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}