import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';

class DotIndicator extends StatelessWidget {
  bool active;
   DotIndicator({super.key,required this.active});

  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
      duration: Duration(microseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: active? 20 :10,
        height : 10,
        decoration: BoxDecoration(
            color: active?AppColor.Gold:Colors.grey[400],
            borderRadius: BorderRadius.circular(20)
        ),

    );
  }
}
