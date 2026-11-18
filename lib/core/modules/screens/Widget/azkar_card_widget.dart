import 'package:flutter/material.dart';
import '../../../themes/app_color.dart';

class AzkarModel {
  final String title;
  final String image;
  final String categoryKey;

  AzkarModel({
    required this.title,
    required this.image,
    required this.categoryKey,
  });
}

class ZikrItemModel {
  final String category;
  final int count;
  final String description;
  final String reference;
  final String content;
  int currentCount;

  ZikrItemModel({
    required this.category,
    required this.count,
    required this.description,
    required this.reference,
    required this.content,
    int? currentCount,
  }) : currentCount = currentCount ?? count;

  factory ZikrItemModel.fromJson(Map<String, dynamic> json) {
    return ZikrItemModel(
      category: json["category"] ?? "",
      count: int.tryParse(json["count"]?.toString() ?? "1") ?? 1,
      description: json["description"] ?? "",
      reference: json["reference"] ?? "",
      content: json["content"] ?? "",
    );
  }
}

class AzkarCardWidget extends StatelessWidget {
  final AzkarModel azkarModel;
  final VoidCallback? onTap;

  const AzkarCardWidget({
    super.key,
    required this.azkarModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColor.Gold,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  azkarModel.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, left: 8.0, right: 8.0),
              child: Text(
                azkarModel.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColor.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
