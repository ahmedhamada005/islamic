import 'package:flutter/material.dart';
import '../../../themes/app_color.dart';

class RadioModel {
  final String title;
  bool isPlaying;
  bool isMuted;

  RadioModel({
    required this.title,
    this.isPlaying = false,
    this.isMuted = false,
  });
}

class RadioItemWidget extends StatelessWidget {
  final RadioModel radioModel;
  final VoidCallback onPlayPause;
  final VoidCallback onToggleMute;

  const RadioItemWidget({
    super.key,
    required this.radioModel,
    required this.onPlayPause,
    required this.onToggleMute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 133,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.Gold,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background silhouette / watermark
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: radioModel.isPlaying
                  ? Image.asset(
                      "assets/images/radio_soundwave.png",
                      height: 75,
                      fit: BoxFit.cover,
                      opacity: const AlwaysStoppedAnimation(0.28),
                    )
                  : Image.asset(
                      "assets/images/radio_mosque_bg.png",
                      height: 85,
                      fit: BoxFit.cover,
                      opacity: const AlwaysStoppedAnimation(0.28),
                    ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      radioModel.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColor.backgroundColor,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Controls Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Play / Pause button
                      GestureDetector(
                        onTap: onPlayPause,
                        child: Icon(
                          radioModel.isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 38,
                          color: AppColor.backgroundColor,
                        ),
                      ),
                      const SizedBox(width: 24),
                      // Volume / Mute button
                      GestureDetector(
                        onTap: onToggleMute,
                        child: Image.asset(
                          radioModel.isMuted
                              ? "assets/images/volume_cross.png"
                              : "assets/images/volume_high.png",
                          width: 26,
                          height: 26,
                          color: AppColor.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
