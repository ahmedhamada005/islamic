import 'package:flutter/material.dart';
import 'package:islamic/core/modules/layout/screnns/layout_screen.dart';
import 'package:islamic/core/modules/screens/OnBoordingScreen/OnBording_Model.dart';
import 'package:islamic/core/modules/screens/OnBoordingScreen/dot_indicator.dart';
import 'package:islamic/core/themes/app_color.dart';

class OnbordingScreen extends StatefulWidget {
  OnbordingScreen({super.key});

  static const String RouteName = "/OnbordingScreen";

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  PageController pageController = PageController();
  int CurrentIndex = 0;

  @override
  void initState() {
    pageController.addListener(() {
      CurrentIndex = pageController.page!.toInt();
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<OnBordingModel> OnBordingList = [
    OnBordingModel(
      Imagepath: ("assets/images/bording1.png"),
      Titel: "Welcome To Islmi App",
    ),
    OnBordingModel(
      Imagepath: ("assets/images/bording2.png"),
      Titel: "Welcome To Islmi App",
      descrabtion: "We Are Very Excited To Have You In Our \n Community",
    ),
    OnBordingModel(
      Imagepath: ("assets/images/bording3.png"),
      Titel: "Reading the Quran",
      descrabtion: "Read, and your Lord is the Most Generous",
    ),
    OnBordingModel(
      Imagepath: ("assets/images/bording4.png"),
      Titel: "Bearish",
      descrabtion: "Praise the name of your Lord, the Most \n High",
    ),
    OnBordingModel(
      Imagepath: ("assets/images/bording5.png"),
      Titel: "Holy Quran Radio",
      descrabtion:
          "You can listen to the Holy Quran Radio through the application for free and easily",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/images/mosq.png", height: size.height * 0.15),
            SizedBox(height: 18),
            Expanded(
              flex: 8,
              child: PageView.builder(
                controller: pageController,
                itemCount: OnBordingList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(
                        OnBordingList[index].Imagepath,
                        height: size.height * 0.45,
                      ), //image
                      SizedBox(height: 18),
                      Text(
                        OnBordingList[index].Titel,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.Gold,
                        ),
                      ), //titel
                      SizedBox(height: 18),
                      if (OnBordingList[index].descrabtion != null)
                        Text(
                          OnBordingList[index].descrabtion!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColor.Gold,
                          ),
                          textAlign: TextAlign.center,
                        ), //body
                    ],
                  );
                },
              ),
            ),
            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: CurrentIndex != 0
                      ? () {
                          pageController.animateToPage(
                            CurrentIndex - 1,
                            duration: Duration(microseconds: 300),
                            curve: Curves.bounceInOut,
                          );
                        }
                      : null,
                  child: Text(
                    CurrentIndex != 0 ? "Back" : " ",
                    style: TextStyle(
                      color: AppColor.Gold,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ), //button back
                Row(
                  children: [
                    DotIndicator(active: CurrentIndex == 0),
                    DotIndicator(active: CurrentIndex == 1),
                    DotIndicator(active: CurrentIndex == 2),
                    DotIndicator(active: CurrentIndex == 3),
                    DotIndicator(active: CurrentIndex == 4),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    if (CurrentIndex == 4) {
                      Navigator.pushReplacementNamed(
                        context,
                        LayoutScreen.routeName,
                      );
                    } else {
                      pageController.animateToPage(
                        CurrentIndex + 1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut,
                      );
                    }
                  },
                  child: Text(
                    CurrentIndex != OnBordingList.length - 1
                        ? "Next"
                        : " Finsh",
                    style: TextStyle(
                      color: AppColor.Gold,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ), //button next
              ],
            ),
          ],
        ),
      ),
    );
  }
}
