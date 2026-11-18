import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic/core/modules/layout/screnns/layout_screen.dart';
import 'package:islamic/core/modules/layout/screnns/quran_details.dart';
import 'package:islamic/core/modules/screens/OnBoordingScreen/OnBording_screen.dart';
import 'package:islamic/core/modules/screens/splash_screen.dart';

import 'core/modules/layout/screnns/azkar_details.dart';
import 'core/modules/layout/screnns/hadeth_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.tajawal().fontFamily
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: OnbordingScreen.RouteName,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        LayoutScreen.routeName:(_)=>LayoutScreen(),
        QuranDetails.RouteName:(_)=>QuranDetails(),
        HadethDetails.RouteName:(_)=>HadethDetails(),
        AzkarDetails.RouteName: (_) => const AzkarDetails(),
        OnbordingScreen.RouteName :(_)=>OnbordingScreen()
      },
    );
  }
}
