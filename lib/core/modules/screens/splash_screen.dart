import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:islamic/core/modules/layout/screnns/layout_screen.dart';
import '../../themes/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static  const String routeName="/splach";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5),() {
      Navigator.pushNamedAndRemoveUntil(context, LayoutScreen.routeName, (route) => false,);

    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ZoomIn(
                duration: Duration(seconds: 2),
                child: Center(
                  child: Image.asset("assets/logo/app_logo.png", width: 343),
                ),
              ),
            ),
            FadeInUpBig(child: Image.asset("assets/logo/route_logo.png", width: 244)),
          ],
        ),
      ),
    );
  }
}
