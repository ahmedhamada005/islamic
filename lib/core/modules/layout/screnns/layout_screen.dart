import 'package:flutter/material.dart';
import 'package:islamic/core/modules/screens/quran_screen.dart';
import 'package:islamic/core/themes/app_color.dart';

import '../../screens/hadeth_screen.dart';
import '../../screens/radio_screen.dart';
import '../../screens/sabha_screen.dart';
import '../../screens/time_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  static const String routeName = "/layout";

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int index = 0;

  List<Widget> Screens = [
    QuranScreen(),
    HadethScreen(),
    SabhaScreen(),
    RadioScreen(),
    TimeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[index],
      backgroundColor: AppColor.backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          index = value;
          setState(() {});
        },
        backgroundColor: AppColor.Gold,
        fixedColor: AppColor.white,

        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(color: AppColor.white),
        selectedIconTheme: IconThemeData(color: AppColor.white),

        items: [
          GetNavBar(label: "Quran", image: "assets/Icon/Quran.png"),
          GetNavBar(label: "Hadeth", image: "assets/Icon/Hadeth.png"),
          GetNavBar(label: "Sabha", image: "assets/Icon/Sabha.png"),
          GetNavBar(label: "Radio", image: "assets/Icon/Radio.png"),
          GetNavBar(label: "Time", image: "assets/Icon/Time.png"),
        ],
      ),
    );
  }

  BottomNavigationBarItem GetNavBar({
    required String label,
    required String image,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(image, width: 32),
      label: label,
      activeIcon: Container(
        child: Image.asset(image, width: 32),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: AppColor.backgroundColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
