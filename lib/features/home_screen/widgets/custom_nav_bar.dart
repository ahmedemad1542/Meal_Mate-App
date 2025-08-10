import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meal_mate/core/theming/app_assets.dart';
import 'package:meal_mate/core/theming/app_colors.dart';
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
    return SizedBox(
      height: 90.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          /// الرسم الخلفي
          CustomPaint(size: Size(1.sw, 75.h), painter: BNBCustomPainter()),

          //floating center button
          Positioned(
            top: -14.h,
            child: GestureDetector(
              onTap: onCenterButtonTap,
              child: Container(
                height: 65.h,
                width: 65.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.black,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 5.r),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.ai,
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
              ),
            ),
          ),

          /// الـ Bottom Navigation Bar
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
                              ? AppColors.orange
                              : AppColors.black;

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
                selectedItemColor: AppColors.black,
                unselectedItemColor: AppColors.black,
                showUnselectedLabels: true,
                selectedLabelStyle: const TextStyle(color: AppColors.black),
                unselectedLabelStyle: const TextStyle(color: Colors.black45),
                type: BottomNavigationBarType.fixed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
