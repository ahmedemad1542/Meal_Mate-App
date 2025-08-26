import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meal_mate/core/theming/app_assets.dart';
import 'package:meal_mate/core/theming/app_colors.dart';
import 'package:meal_mate/core/theming/text_style.dart';
import 'package:meal_mate/core/model/meal_model.dart';

class MealCard extends StatelessWidget {
  final MealModel meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152.w,
      height: 174.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            offset: const Offset(6, 6),
            blurRadius: 69,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 137.w,
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                image: DecorationImage(
                  
                  image: const AssetImage(AppAssets.on3),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(meal.name, style: TextStyles.addMealDeatails),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.star),
                    SizedBox(width: 5.w),
                    const Text('4.9'), 
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.clock),
                    SizedBox(width: 5.w),
                    Text("${meal.cookingTime} min"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
