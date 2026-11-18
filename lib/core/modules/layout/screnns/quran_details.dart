import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic/core/modules/screens/Widget/sura_Widget.dart';
import 'package:islamic/core/themes/app_color.dart';

class QuranDetails extends StatefulWidget {
  QuranDetails({super.key});

  static const String RouteName = "/QuranDetails";

  @override
  State<QuranDetails> createState() => _QuranDetailsState();
}

class _QuranDetailsState extends State<QuranDetails> {
  List<String> SuraList = [];

  @override
  // void initState() {
  //   readFile();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    SuraModel suraModel =
    ModalRoute
        .of(context)!
        .settings
        .arguments as SuraModel;
    if (SuraList.isEmpty) {
      readFile(suraModel.SuraNum);
    }
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColor.Gold,
        title: Text(suraModel.ayaEng),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Image.asset("assets/images/img_left_corner.png")),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      suraModel.ayaArb,
                      style: TextStyle(
                        fontSize: 34,
                        color: AppColor.Gold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Image.asset("assets/images/img_right_corner.png"),
                ),
              ],
            ),

            // Expanded(
            //   child: ListView.builder(
            //     itemCount: SuraList.length,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         padding: EdgeInsets.all(8),
            //         margin: EdgeInsets.all(4),
            //         decoration: BoxDecoration(
            //           border: Border.all(color: AppColor.Gold),
            //           borderRadius: BorderRadius.circular(16),
            //         ),
            //         child: Center(
            //           child: Text(
            //            " ${SuraList[index]} (${index+1})",
            //             style: TextStyle(fontSize: 20, color: AppColor.Gold,fontFamily: GoogleFonts.amiriQuran().fontFamily),
            //             textAlign: TextAlign.center,
            //             textDirection: TextDirection.rtl,
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColor.Gold,
                        fontFamily: GoogleFonts
                            .amiriQuran()
                            .fontFamily,
                        height: 3
                    ),

                    children: SuraList.map((e) {
                      int index = SuraList.indexOf(e);
                      return TextSpan(text: e + "(${index + 1})",
                          style: TextStyle(
                              color: e.contains("اللَّهِ")
                                  ? Colors.deepOrange
                                  : null
                          ),recognizer: TapGestureRecognizer()..onTap=(){
                          showModalBottomSheet(context: context, builder: (context) {
                            return Expanded(
                              child: Container(
                                // decoration: BoxDecoration(
                                //   color: AppColor.white
                                // ),
                                child: Column(
                                  children: [
                                    Center(child: Text(e))
                                  ],
                                ),
                              ),
                            );
                          },);
                        },);
                    }).toList(),
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void readFile(String suraNum) async {
    String sura = await rootBundle.loadString("assets/suras/$suraNum.txt");
    sura = sura.trim();
    SuraList = sura.split("\n");
    setState(() {});
  }
}
