import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../themes/app_color.dart';
import '../../screens/Widget/azkar_card_widget.dart';

class AzkarDetails extends StatefulWidget {
  const AzkarDetails({super.key});

  static const String RouteName = "/AzkarDetails";

  @override
  State<AzkarDetails> createState() => _AzkarDetailsState();
}

class _AzkarDetailsState extends State<AzkarDetails> {
  List<ZikrItemModel> azkarList = [];
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (azkarList.isEmpty && isLoading) {
      final azkarModel = ModalRoute.of(context)!.settings.arguments as AzkarModel;
      loadAzkar(azkarModel.categoryKey);
    }
  }

  Future<void> loadAzkar(String categoryKey) async {
    try {
      final jsonString = await rootBundle.loadString("assets/azkar/azkar.json");
      final Map<String, dynamic> data = json.decode(jsonString);

      if (data.containsKey(categoryKey)) {
        final List<dynamic> rawList = data[categoryKey];
        final List<ZikrItemModel> loaded = [];

        for (var item in rawList) {
          if (item is Map<String, dynamic>) {
            loaded.add(ZikrItemModel.fromJson(item));
          } else if (item is List) {
            for (var subItem in item) {
              if (subItem is Map<String, dynamic>) {
                loaded.add(ZikrItemModel.fromJson(subItem));
              }
            }
          }
        }

        setState(() {
          azkarList = loaded;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _decrementCount(int index) {
    if (azkarList[index].currentCount > 0) {
      HapticFeedback.lightImpact();
      setState(() {
        azkarList[index].currentCount--;
      });
    }
  }

  void _resetCount(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      azkarList[index].currentCount = azkarList[index].count;
    });
  }

  @override
  Widget build(BuildContext context) {
    final azkarModel = ModalRoute.of(context)!.settings.arguments as AzkarModel;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColor.Gold,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header with corners
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Image.asset("assets/images/img_left_corner.png"),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      azkarModel.title,
                      style: const TextStyle(
                        fontSize: 26,
                        color: AppColor.Gold,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Image.asset("assets/images/img_right_corner.png"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Content
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColor.Gold),
                  )
                : azkarList.isEmpty
                    ? const Center(
                        child: Text(
                          "لا توجد أذكار في هذا القسم",
                          style: TextStyle(color: AppColor.white, fontSize: 18),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        itemCount: azkarList.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final item = azkarList[index];
                          final isCompleted = item.currentCount == 0;

                          return Container(
                            decoration: BoxDecoration(
                              color: AppColor.backgroundColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isCompleted
                                    ? Colors.green.withValues(alpha: 0.6)
                                    : AppColor.Gold,
                                width: 1.5,
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Zikr Content
                                Text(
                                  item.content,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    height: 1.6,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (item.description.isNotEmpty) ...[
                                  const SizedBox(height: 12),
                                  Text(
                                    item.description,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.4,
                                      color: AppColor.Gold.withValues(alpha: 0.85),
                                    ),
                                  ),
                                ],
                                if (item.reference.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    item.reference,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.white.withValues(alpha: 0.5),
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 14),
                                // Actions Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (item.currentCount < item.count)
                                      IconButton(
                                        onPressed: () => _resetCount(index),
                                        icon: const Icon(
                                          Icons.refresh,
                                          color: AppColor.Gold,
                                          size: 20,
                                        ),
                                        tooltip: "إعادة العداد",
                                      )
                                    else
                                      const SizedBox(width: 48),
                                    // Counter Button
                                    GestureDetector(
                                      onTap: () => _decrementCount(index),
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isCompleted
                                              ? Colors.green
                                              : AppColor.Gold,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: isCompleted
                                            ? const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.check,
                                                    size: 16,
                                                    color: AppColor.white,
                                                  ),
                                                  SizedBox(width: 6),
                                                  Text(
                                                    "اكتمل",
                                                    style: TextStyle(
                                                      color: AppColor.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                "${item.currentCount}",
                                                style: const TextStyle(
                                                  color:
                                                      AppColor.backgroundColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(width: 48),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
