import 'package:flutter/material.dart';
import 'package:islamic/core/modules/layout/screnns/quran_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../themes/app_color.dart';

class SuraWidget extends StatelessWidget {
   SuraWidget({super.key, required this.suraModel,required this.OnBack});

  final SuraModel suraModel;
   Function ()OnBack;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, QuranDetails.RouteName,arguments: suraModel).then(OnBack());
        SaveSura();
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/images/aya.png", height: 60, width: 60),
                Text(
                  suraModel.SuraNum,
                  style: TextStyle(
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suraModel.ayaEng,
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    suraModel.ayaNum + "  Verses",
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  suraModel.ayaArb,
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  SaveSura() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>MostResantly=prefs.getStringList("MostResantly")??[];
    MostResantly.insert(0,suraModel.SuraNum);
   MostResantly= MostResantly.toSet().toList();
    prefs.setStringList("MostResantly", MostResantly);
  }
}

class SuraModel {
  String ayaEng;
  String ayaNum;
  String ayaArb;
  String SuraNum;

  SuraModel({
    required this.ayaEng,
    required this.ayaNum,
    required this.ayaArb,
    required this.SuraNum,
  });
}
