import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/core/theming/app_assets.dart';
import 'package:meal_mate/core/theming/app_colors.dart';

class WelcomeImageHome extends StatelessWidget {
  const WelcomeImageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// Background image
          Image.asset(AppAssets.home, fit: BoxFit.cover),

          /// Overlay text
          Positioned(
            left: 16,
            bottom: 16,
            child: Text(
               "welcome_back".tr(),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.6),
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
