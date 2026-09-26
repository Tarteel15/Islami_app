import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../core/constants/app_colors.dart';
import '../../models/hadeth_model.dart';
import 'hadeth_details_screen.dart';

class HadethScreen extends StatefulWidget {
  const HadethScreen({super.key});

  @override
  State<HadethScreen> createState() => _HadethScreenState();
}

class _HadethScreenState extends State<HadethScreen> {
  List<HadethModel> _ahadeth = [];
  late PageController _pageController;
  int _activePage = 5000; // صفحة البداية للـ Infinite Scroll

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _activePage,
      viewportFraction: 0.82,
    );
    _loadAllHadeth();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadAllHadeth() async {
    List<HadethModel> list = [];
    for (int i = 1; i <= 50; i++) {
      try {
        String data = await rootBundle.loadString('assets/hadeeth/h$i.txt');
        List<String> lines = data.trim().split('\n');
        String title = lines[0];
        lines.removeAt(0);
        String body = lines.join('\n');
        list.add(HadethModel(title: title, content: body));
      } catch (_) {
        break;
      }
    }
    if (list.isEmpty) {
      list = [
        HadethModel(
          title: 'الحديث الأول',
          content:
              'عن أمير المؤمنين أبي حفص عمر بن الخطاب رضي الله عنه ، قال : سمعت رسول الله صلى الله عليه وسلم يقول : ( إنما الأعمال بالنيات وإنما لكل امرئ ما نوى . فمن كانت هجرته إلى الله ورسوله فهجرته إلى الله ورسوله ومن كانت هجرته لدنيا يصيبها أو امرأة ينكحها فهجرته إلى ما هاجر إليه ).\n\nرواه إمام المحدثين أبو عبد الله محمد بن إسماعيل بن إبراهيم بن المغيرة بن بردزبه البخاري الجعفي [رقم:1] وابو الحسين مسلم بن الحجاج بن مسلم القشيري النيسابوري [رقم: 1907] رضي الله عنهما في صحيحيهما اللذين هما أصح الكتب المصنفه.',
        ),
      ];
    }
    setState(() => _ahadeth = list);
  }

  @override
  Widget build(BuildContext context) {
    if (_ahadeth.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: AppColors.gold));
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. صورة خلفية الشاشة الكاملة hadethbg.png
          Image.asset(
            'assets/images/hadethbg.png',
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
          Container(
            color: Colors.black.withOpacity(0.3),
          ),

          // 3. المحتوى
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),

                // هيدر المسجد وشعار Islami
                SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: 0.35,
                        child: Image.asset(
                          'assets/images/Mosque-01.png',
                          height: 130,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const SizedBox(),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
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

                const SizedBox(height: 12),

                // كروت الأحاديث الدائرية اللانهائية
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 100000, // عدد كبير جداً ليسمح بالدوران اللانهائي
                    onPageChanged: (pageIndex) {
                      setState(() {
                        _activePage = pageIndex;
                      });
                    },
                    itemBuilder: (context, index) {
                      final realIndex = index % _ahadeth.length;
                      final hadeth = _ahadeth[realIndex];
                      final bool isSelected = index == _activePage;

                      return AnimatedScale(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        scale: isSelected ? 1.0 : 0.88, // الكارت اللي في النص أكبر من اللي جنبه
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HadethDetailsScreen(hadeth: hadeth),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.gold,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Stack(
                                children: [
                                  // خلفية الكارت المصغرة في المنتصف
                                  Center(
                                    child: Opacity(
                                      opacity: 0.28,
                                      child: Image.asset(
                                        'assets/images/HadithCardBackGround.png',
                                        width: 230,
                                        height: 230,
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, __, ___) => const SizedBox(),
                                      ),
                                    ),
                                  ),

                                  // المساجد أسفل الكارت
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Image.asset(
                                      'assets/images/Mosque-02.png',
                                      fit: BoxFit.fill,
                                      height: 85,
                                    ),
                                  ),

                                  // نصوص الحديث
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 18),
                                        // عنوان الحديث
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 45.0),
                                          child: Text(
                                            hadeth.title,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: 'Janna',
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 14),

                                        // نص الحديث القابل للتمرير
                                        Expanded(
                                          child: SingleChildScrollView(
                                            physics: const BouncingScrollPhysics(),
                                            padding: const EdgeInsets.only(bottom: 75),
                                            child: Text(
                                              hadeth.content,
                                              textAlign: TextAlign.center,
                                              textDirection: TextDirection.rtl,
                                              style: const TextStyle(
                                                fontFamily: 'Janna',
                                                fontSize: 16,
                                                height: 1.85,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // الكورنر الأيسر بأبعاد فيجما 93x100
                                  Positioned(
                                    top: 10,
                                    left: 8,
                                    child: Image.asset(
                                      'assets/images/left_corner.png',
                                      width: 150,
                                      height:100,
                                      fit: BoxFit.contain,
                                      errorBuilder: (_, __, ___) => const SizedBox(),
                                    ),
                                  ),

                                  // الكورنر الأيمن بأبعاد فيجما 93x100
                                  Positioned(
                                    top: 10,
                                    right: 8,
                                    child: Image.asset(
                                      'assets/images/right_corner.png',
                                      width: 93,
                                      height: 100,
                                      fit: BoxFit.contain,
                                      errorBuilder: (_, __, ___) => const SizedBox(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}