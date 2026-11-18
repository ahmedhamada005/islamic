import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../themes/app_color.dart';
import 'Widget/radio_item_widget.dart';
import 'Widget/radio_tab_switcher.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  static const String routeName = "/radio";

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  int selectedTab = 0; // 0 for Radio, 1 for Reciters

  late List<RadioModel> radioStations;
  late List<RadioModel> reciters;

  @override
  void initState() {
    super.initState();
    radioStations = [
      RadioModel(title: "Radio Ibrahim Al-Akdar"),
      RadioModel(title: "Radio Al-Qaria Yassen", isPlaying: true, isMuted: true),
      RadioModel(title: "Radio Ahmed Al-trabulsi"),
      RadioModel(title: "Radio Addokali Mohammad Alalim"),
    ];

    reciters = [
      RadioModel(title: "Ibrahim Al-Akdar"),
      RadioModel(title: "Akram Alalaqmi", isPlaying: true, isMuted: true),
      RadioModel(title: "Majed Al-Enezi"),
      RadioModel(title: "Malik shaibat Alhamed"),
    ];
  }

  void _onPlayPause(List<RadioModel> list, int index) {
    HapticFeedback.lightImpact();
    setState(() {
      final wasPlaying = list[index].isPlaying;
      for (var item in list) {
        item.isPlaying = false;
      }
      list[index].isPlaying = !wasPlaying;
    });
  }

  void _onToggleMute(List<RadioModel> list, int index) {
    HapticFeedback.selectionClick();
    setState(() {
      list[index].isMuted = !list[index].isMuted;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentList = selectedTab == 0 ? radioStations : reciters;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg_radio.jpg"),
          fit: BoxFit.cover,
          opacity: 0.25,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Image.asset("assets/images/quran_header.png"),
            const SizedBox(height: 16),
            RadioTabSwitcher(
              selectedTab: selectedTab,
              onTabChanged: (index) {
                HapticFeedback.lightImpact();
                setState(() {
                  selectedTab = index;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: currentList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  return RadioItemWidget(
                    radioModel: currentList[index],
                    onPlayPause: () => _onPlayPause(currentList, index),
                    onToggleMute: () => _onToggleMute(currentList, index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
