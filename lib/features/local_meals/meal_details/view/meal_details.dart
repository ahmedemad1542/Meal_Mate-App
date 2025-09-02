

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/features/local_meals/meal_details/widgets/cooking_time_widget.dart';
import 'package:meal_mate/features/local_meals/meal_details/widgets/meal_description_widget.dart';
import 'package:meal_mate/features/local_meals/meal_details/widgets/meal_image_widget.dart';
import 'package:meal_mate/features/local_meals/meal_details/widgets/meal_name_widget.dart';

class MealDetailsScreen extends StatelessWidget {
  final MealModel meal;
  final int mealKey;

  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.mealKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.name,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Meal Image
            MealImageWidget(imagePath: meal.imagePath),

            SizedBox(height: 24.h),

            /// Meal Name
            MealNameWidget(name: meal.name),

            SizedBox(height: 12.h),

            /// Cooking Time
            CookingTimeWidget(cookingTime: meal.cookingTime),

            SizedBox(height: 24.h),

            /// Description
            MealDescriptionWidget(description: meal.description),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
