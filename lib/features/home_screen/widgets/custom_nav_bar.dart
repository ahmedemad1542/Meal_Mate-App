import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meal_mate/core/theming/app_assets.dart';
import 'package:meal_mate/core/theming/custom_colors.dart';
import 'package:meal_mate/core/widgets/custom_painter.dart';
import 'package:meal_mate/features/home_screen/custom_navigaton_bar/model/bottom_nav_items.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavItems> items;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onCenterButtonTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTabSelected,
    required this.onCenterButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 90.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          CustomPaint(size: Size(1.sw, 75.h), painter: BNBCustomPainter()),
          Positioned(
            top: -10.h,
            child: GestureDetector(
              onTap: onCenterButtonTap,
              child: Container(
                height: 65.h,
                width: 65.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.surface,
                  boxShadow: [
                    BoxShadow(color: colors.elevationShadow, blurRadius: 5.r),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.chatbot,
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: currentIndex,
                onTap: (index) {
                  if (index == 2) return;
                  onTabSelected(index);
                },
                items:
                    items.asMap().entries.map((entry) {
                      int idx = entry.key;
                      BottomNavItems item = entry.value;
                      Color iconColor =
                          (idx == currentIndex)
                              ? colors.primary
                              : colors.onSurface;

                      if (item.iconWidget == null) {
                        return const BottomNavigationBarItem(
                          icon: SizedBox.shrink(),
                          label: '',
                        );
                      }

                      return BottomNavigationBarItem(
                        icon: Padding(
                          padding: EdgeInsets.only(top: 1.0.h),
                          child: IconTheme(
                            data: IconThemeData(color: iconColor),
                            child: item.iconWidget!,
                          ),
                        ),
                        label: item.label,
                      );
                    }).toList(),
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black.withOpacity(0.6),
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
