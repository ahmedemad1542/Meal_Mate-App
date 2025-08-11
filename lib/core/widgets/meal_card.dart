import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meal_mate/core/theming/app_assets.dart';
import 'package:meal_mate/core/theming/text_style.dart';

class MealCard extends StatelessWidget {
  const MealCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 153.w,
    height: 176.h,decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.r)
    ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          Container(
            width: 137.w,height: 106.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(image:AssetImage(AppAssets.home),fit: BoxFit.cover)
            ),
          ),
          Container(width: 137.w,height: 46.h,
          child: Column(
            children: [
              Text('Burger',style: TextStyles.yourFoodTitle,)
              ,Row(
                children: [
                  SvgPicture.asset(AppAssets.star),Text('4.9',style: TextStyles.yourFoodTitle,),
                  SizedBox(width: 10.w,),
                  SvgPicture.asset(AppAssets.ai),Text('20-30',style: TextStyles.yourFoodTitle,),
                
              ])
              
            ],
          ),)
          ],
        ),
      ),
    );
  }
}
//Todo
//fix meal card according to figma design