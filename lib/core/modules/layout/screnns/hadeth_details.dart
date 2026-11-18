import 'package:flutter/material.dart';
import 'package:islamic/core/modules/screens/hadeth_screen.dart';
import 'package:islamic/core/themes/app_color.dart';

class HadethDetails extends StatelessWidget {
  const HadethDetails({super.key});

  static const String RouteName = "/HadethDetails";



  @override
  Widget build(BuildContext context) {
    HadethData hadethData = ModalRoute
        .of(context)!
        .settings
        .arguments as HadethData;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColor.Gold,
      ),
      body: Column(
        children: [
          Hero(
            tag: hadethData.titile,
            child: Row(
              children: [
                Expanded(
                    child: Image.asset("assets/images/img_left_corner.png")),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Material(

                      color: Colors.transparent,
                      child: Text(
                        hadethData.titile,
                        style: TextStyle(
                          fontSize: 34,
                          color: AppColor.Gold,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Image.asset("assets/images/img_right_corner.png"),
                ),
              ],
            ),
          ),
          SizedBox(height: 26,),
          Expanded(
            child: SingleChildScrollView(
              child: Text(hadethData.body, textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: AppColor.Gold,

                ),),
            ),
          )
        ],
      ),

    );
  }
}
