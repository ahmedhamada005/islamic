import 'package:flutter/material.dart';
import '../../../themes/app_color.dart';

class RadioTabSwitcher extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const RadioTabSwitcher({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 40,
      decoration: BoxDecoration(
        color: AppColor.backgroundColor.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Radio Tab
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(0),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selectedTab == 0 ? AppColor.Gold : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Radio",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: selectedTab == 0
                        ? AppColor.backgroundColor
                        : AppColor.white,
                  ),
                ),
              ),
            ),
          ),
          // Reciters Tab
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(1),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selectedTab == 1 ? AppColor.Gold : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Reciters",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: selectedTab == 1
                        ? AppColor.backgroundColor
                        : AppColor.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
