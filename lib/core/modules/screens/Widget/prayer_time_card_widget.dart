import 'package:flutter/material.dart';
import '../../../themes/app_color.dart';

class PrayerTimeModel {
  final String name;
  final String time;
  final String period;
  final bool isActive;

  PrayerTimeModel({
    required this.name,
    required this.time,
    this.period = "PM",
    this.isActive = false,
  });
}

class PrayerItemWidget extends StatelessWidget {
  final PrayerTimeModel prayer;

  const PrayerItemWidget({
    super.key,
    required this.prayer,
  });

  @override
  Widget build(BuildContext context) {
    final double cardWidth = prayer.isActive ? 98 : 82;
    final double cardHeight = prayer.isActive ? 124 : 106;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: prayer.isActive
              ? [
                  const Color(0xFF202020),
                  const Color(0xFFB19056),
                ]
              : [
                  const Color(0xFF2A2A2A),
                  const Color(0xFF7A6237),
                ],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            prayer.name,
            style: TextStyle(
              fontSize: prayer.isActive ? 15 : 13,
              fontWeight: FontWeight.w700,
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            prayer.time,
            style: TextStyle(
              fontSize: prayer.isActive ? 28 : 22,
              fontWeight: FontWeight.w700,
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            prayer.period,
            style: TextStyle(
              fontSize: prayer.isActive ? 15 : 13,
              fontWeight: FontWeight.w700,
              color: AppColor.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PrayerTimeCardWidget extends StatelessWidget {
  final List<PrayerTimeModel> prayers;
  final String gregorianDate;
  final String hijriDate;
  final String dayName;
  final String nextPrayCountdown;
  final bool isMuted;
  final VoidCallback? onToggleMute;

  const PrayerTimeCardWidget({
    super.key,
    required this.prayers,
    this.gregorianDate = "16 Jul,\n2024",
    this.hijriDate = "09 Muh,\n1446",
    this.dayName = "Tuesday",
    this.nextPrayCountdown = "02:32",
    this.isMuted = true,
    this.onToggleMute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 301,
      child: Stack(
        children: [
          // Background shape
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                "assets/images/pray_card_bg.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                // Top Header Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gregorian Date
                    Text(
                      gregorianDate,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                        height: 1.2,
                      ),
                    ),
                    const Spacer(),
                    // Center Title
                    Column(
                      children: [
                        Text(
                          "Pray Time",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColor.backgroundColor.withValues(alpha: 0.7),
                          ),
                        ),
                        Text(
                          dayName,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: AppColor.backgroundColor.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Hijri Date
                    Text(
                      hijriDate,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Horizontal list of prayers
                SizedBox(
                  height: 130,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    itemCount: prayers.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return Center(
                        child: PrayerItemWidget(prayer: prayers[index]),
                      );
                    },
                  ),
                ),
                const Spacer(),
                // Bottom Row: Next Pray & Volume toggle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Next Pray - ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColor.backgroundColor.withValues(alpha: 0.75),
                                fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
                              ),
                            ),
                            TextSpan(
                              text: nextPrayCountdown,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColor.backgroundColor,
                                fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: onToggleMute,
                        child: Icon(
                          isMuted ? Icons.volume_off : Icons.volume_up,
                          size: 22,
                          color: AppColor.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
