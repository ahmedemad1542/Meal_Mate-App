import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/core/theming/app_assets.dart';
import 'package:meal_mate/core/theming/app_colors.dart';

class MealCard extends StatelessWidget {
  final MealModel meal;
  final int? mealKey;

  const MealCard({super.key, required this.meal, this.mealKey});

  @override
  Widget build(BuildContext context) {
    final mealsBox = Hive.box<MealModel>('meals');
    final actualMealKey =
        mealKey ??
        mealsBox.keys.firstWhere(
          (key) => mealsBox.get(key) == meal,
          orElse: () => 0,
        );

    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: GestureDetector(
        // Normal tap - Navigate to details
        onTap: () {
          context.push(AppRoutes.mealDetailsScreen, extra: meal);

          ;
        },
        // Long press (update/delete)
        onLongPress: () {
          _showOptionsBottomSheet(context, actualMealKey);
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Meal Image (if available)
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.r),
                    ),
                  ),
                  child:
                      meal.imagePath != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12.r),
                            ),
                            child: Image.network(
                              meal.imagePath!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildPlaceholderImage();
                              },
                            ),
                          )
                          : _buildPlaceholderImage(),
                ),
              ),

              // Content
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Meal Name
                      Center(
                        child: Text(
                          meal.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Cooking Time and rating
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.clock),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              '${meal.cookingTime} min',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SvgPicture.asset(AppAssets.star),
                          SizedBox(width: 4.w),
                          Text(
                            meal.rating.toString(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      // Description Preview
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: Center(
        child: Icon(Icons.restaurant, size: 30.sp, color: Colors.grey[600]),
      ),
    );
  }

  void _showOptionsBottomSheet(BuildContext context, int actualMealKey) {
    final mealsBox = Hive.box<MealModel>('meals');

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),

                SizedBox(height: 20.h),

                // Meal name
                Text(
                  meal.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20.h),

                // Update Option
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(Icons.edit, color: Colors.blue, size: 24.sp),
                  ),
                  title: Text(
                    'Update Meal',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    'Edit meal information',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to update screen using GoRouter
                    context.push(AppRoutes.updateMealScreen, extra: meal);
                  },
                ),

                // Delete Option
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(Icons.delete, color: Colors.red, size: 24.sp),
                  ),
                  title: Text(
                    'Delete Meal',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    'Remove meal permanently',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showDeleteConfirmation(context, actualMealKey, mealsBox);
                  },
                ),

                SizedBox(height: 10.h),
              ],
            ),
          ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    int mealKey,
    Box<MealModel> mealsBox,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            title: Row(
              children: [
                Icon(Icons.warning, color: Colors.red, size: 24.sp),
                SizedBox(width: 8.w),
                const Text('Delete Meal'),
              ],
            ),
            content: Text(
              'Are you sure you want to delete "${meal.name}"? This action cannot be undone.',
              style: TextStyle(fontSize: 16.sp),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16.sp),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);

                  try {
                    await mealsBox.delete(mealKey);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${meal.name} deleted successfully'),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to delete meal: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text('Delete', style: TextStyle(fontSize: 16.sp)),
              ),
            ],
          ),
    );
  }
}
