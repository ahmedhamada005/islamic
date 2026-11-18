import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../themes/app_color.dart';

class SabhaScreen extends StatefulWidget {
  const SabhaScreen({super.key});

  static const String routeName = "/sabha";

  @override
  State<SabhaScreen> createState() => _SabhaScreenState();
}

class _SabhaScreenState extends State<SabhaScreen> {
  int counter = 0;
  double turns = 0.0;
  int currentZikrIndex = 0;

  final List<String> azkar = [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
    "لا إله إلا الله",
  ];

  void _onSebhaTap() {
    HapticFeedback.lightImpact();
    setState(() {
      counter++;
      turns += 1.0 / 30.0;
      if (counter == 33) {
        counter = 0;
        currentZikrIndex = (currentZikrIndex + 1) % azkar.length;
      }
    });
  }

  void _nextZikr() {
    HapticFeedback.mediumImpact();
    setState(() {
      currentZikrIndex = (currentZikrIndex + 1) % azkar.length;
      counter = 0;
    });
  }

  void _resetCounter() {
    HapticFeedback.vibrate();
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_sebha.jpg"),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Image.asset("assets/images/quran_header.png"),
             SizedBox(height: 16),
             Text(
              "سَبِّحِ اسْمَ رَبِّكَ الأعلى ",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColor.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double sebhaWidth = constraints.maxWidth * 0.85;
                    if (sebhaWidth > 360) sebhaWidth = 360;

                    double scale = sebhaWidth / 379.0;
                    double headWidth = 73.0 * scale;
                    double headHeight = 86.0 * scale;
                    double overlap = 7.0 * scale;
                    double totalHeight = headHeight - overlap + sebhaWidth;

                    if (totalHeight > constraints.maxHeight) {
                      double heightScale = constraints.maxHeight / totalHeight;
                      sebhaWidth *= heightScale;
                      scale = sebhaWidth / 379.0;
                      headWidth = 73.0 * scale;
                      headHeight = 86.0 * scale;
                      overlap = 7.0 * scale;
                      totalHeight = headHeight - overlap + sebhaWidth;
                    }

                    return GestureDetector(
                      onTap: _onSebhaTap,
                      behavior: HitTestBehavior.opaque,
                      child: SizedBox(
                        width: sebhaWidth,
                        height: totalHeight,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          clipBehavior: Clip.none,
                          children: [
                            // Head of Sebha
                            Positioned(
                              top: 0,
                              left: (sebhaWidth / 2) - (4.0 * scale),
                              child: Image.asset(
                                "assets/images/sebha_head.png",
                                width: headWidth,
                                height: headHeight,
                                fit: BoxFit.contain,
                              ),
                            ),
                            // Body of Sebha with rotation and centered texts
                            Positioned(
                              top: headHeight - overlap,
                              left: 0,
                              right: 0,
                              height: sebhaWidth,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AnimatedRotation(
                                    turns: turns,
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeOutBack,
                                    child: Image.asset(
                                      "assets/images/sebha_body.png",
                                      width: sebhaWidth,
                                      height: sebhaWidth,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: _nextZikr,
                                        child: Text(
                                          azkar[currentZikrIndex],
                                          style: TextStyle(
                                            fontSize: (sebhaWidth * 0.09).clamp(24.0, 36.0),
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(height: sebhaWidth * 0.03),
                                      GestureDetector(
                                        onLongPress: _resetCounter,
                                        child: Text(
                                          "$counter",
                                          style: TextStyle(
                                            fontSize: (sebhaWidth * 0.1).clamp(28.0, 40.0),
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
