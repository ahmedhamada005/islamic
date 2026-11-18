import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamic/core/modules/layout/screnns/hadeth_details.dart';
import '../../themes/app_color.dart';

class HadethScreen extends StatefulWidget {
  const HadethScreen({super.key});

  @override
  State<HadethScreen> createState() => _HadethScreenState();
}
List<HadethData> Hadeth=[];

class _HadethScreenState extends State<HadethScreen> {
  @override
  Widget build(BuildContext context) {
    if(Hadeth.isEmpty){
      readhadeth();
    }
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_hadeth.jpg"),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Image.asset("assets/images/quran_header.png"),
            const SizedBox(height: 15),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: double.infinity,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                  viewportFraction: 0.78, // هذه الخاصية هي التي تترك المسافة من الجوانب
                  enableInfiniteScroll: true,
                ),
                items: Hadeth.map((HadethData) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        onTap: () {
                         Navigator.pushNamed(context, HadethDetails.RouteName,arguments: HadethData);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.Gold,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    "assets/images/hadeth_fotter.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Hero(
                                      tag: HadethData.titile,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Image.asset(
                                              "assets/images/img_left_corner.png",
                                              color: AppColor.backgroundColor,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Text(
                                                   HadethData.titile,
                                                    style: TextStyle(
                                                      fontSize: 28,
                                                      color: AppColor.backgroundColor,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Image.asset(
                                              "assets/images/img_right_corner.png",
                                              color: AppColor.backgroundColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(HadethData.body,style: TextStyle(
                                      fontSize: 16,
                                    ),textAlign: TextAlign.center,textDirection: TextDirection.rtl,)
                                  ],

                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void readhadeth()async{
    for (int i=1;i<=50;i++){
      String data= await rootBundle.loadString("assets/hadeeth/h$i.txt");
      data =data.trim();
      List<String> hadethList=data.split("\n");
      Hadeth.add(HadethData(titile: hadethList[0].trim(), body: hadethList[1].trim()));

    }
    setState(() {

    });

  }
}
class HadethData{
  String titile;
  String body;

  HadethData({required this.titile, required this.body});
}