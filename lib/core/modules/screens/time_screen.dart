import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../themes/app_color.dart';
import '../layout/screnns/azkar_details.dart';
import 'Widget/azkar_card_widget.dart';
import 'Widget/prayer_time_card_widget.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  static const String routeName = "/time";

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  bool isMuted = true;

  final List<PrayerTimeModel> prayers = [
    PrayerTimeModel(name: "Sunrise", time: "01:04", period: "PM"),
    PrayerTimeModel(name: "Dhuhr", time: "01:01", period: "PM"),
    PrayerTimeModel(name: "ASR", time: "04:38", period: "PM", isActive: true),
    PrayerTimeModel(name: "Maghrib", time: "07:57", period: "PM"),
    PrayerTimeModel(name: "Isha", time: "09:57", period: "PM"),
  ];

  final List<AzkarModel> azkarList = [
    AzkarModel(
      title: "Evening Azkar",
      image: "assets/images/evening_azkar.png",
      categoryKey: "أذكار المساء",
    ),
    AzkarModel(
      title: "Morning Azkar",
      image: "assets/images/morning_azkar.png",
      categoryKey: "أذكار الصباح",
    ),
    AzkarModel(
      title: "Waking Azkar",
      image: "assets/images/waking_azkar.png",
      categoryKey: "أذكار الاستيقاظ",
    ),
    AzkarModel(
      title: "Sleeping Azkar",
      image: "assets/images/sleeping_azkar.png",
      categoryKey: "أذكار النوم",
    ),
  ];

  void _onToggleMute() {
    HapticFeedback.selectionClick();
    setState(() {
      isMuted = !isMuted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_time.jpg"),
          fit: BoxFit.cover,
          opacity: 0.25,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Image.asset("assets/images/quran_header.png"),
              ),
              const SizedBox(height: 16),
              PrayerTimeCardWidget(
                prayers: prayers,
                isMuted: isMuted,
                onToggleMute: _onToggleMute,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Azkar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFEFFE8),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: azkarList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    return AzkarCardWidget(
                      azkarModel: azkarList[index],
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.pushNamed(
                          context,
                          AzkarDetails.RouteName,
                          arguments: azkarList[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
