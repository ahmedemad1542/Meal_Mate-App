import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/model/meal_model.dart';

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
            // Meal Image (if available)
           Container(
  height: 200.h,
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.r),
    color: Colors.grey[300],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12.r),
    child: _buildMealImage(meal.imagePath),
  ),
),


            SizedBox(height: 24.h),

            // Meal Name
            Text(
              meal.name,
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 12.h),

            // Cooking Time
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.access_time, color: Colors.orange, size: 18.sp),
                  SizedBox(width: 6.w),
                  Text(
                    '${meal.cookingTime} minutes',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Description Title
            Text(
              'Description',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 12.h),

            // Description Content
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    meal.description,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
  Widget _buildMealImage(String? imagePath) {
  if (imagePath == null) {
    return Icon(Icons.restaurant_menu, size: 60.sp, color: Colors.grey[600]);
  }

  if (imagePath.startsWith("http")) {
    return Image.network(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.broken_image, size: 60.sp, color: Colors.grey[600]);
      },
    );
  } else {
    return Image.file(
      File(imagePath),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.broken_image, size: 60.sp, color: Colors.grey[600]);
      },
    );
  }
}

}
