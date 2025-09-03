import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/core/theming/app_assets.dart';

import 'package:meal_mate/core/theming/custom_colors.dart';

class MealCard extends StatelessWidget {
  final MealModel meal;
  final int? mealKey;

  const MealCard({super.key, required this.meal, this.mealKey});

  @override
  Widget build(BuildContext context) {
    final mealsBox = Hive.box<MealModel>('meals');
    final colors = Theme.of(context).colorScheme;
    final custom = colors; // CustomColors extension على ColorScheme
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
        onTap: () {
          context.push(AppRoutes.mealDetailsScreen, extra: meal);
        },
        onLongPress: () {
          _showOptionsBottomSheet(context, actualMealKey);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: custom.apiMealCardBackground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Meal Image
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.r),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.r),
                    ),
                    child: _buildMealImage(meal.imagePath, custom),
                  ),
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
                            color: custom.areaCardText,
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
                                color: custom.secondaryText,
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
                              color: custom.secondaryText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildPlaceholderImage(ColorScheme custom) {
    return Container(
      decoration: BoxDecoration(
        color: custom.brokenImageIcon.withOpacity(0.2),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: Center(
        child: Icon(Icons.restaurant, size: 30.sp, color: custom.brokenImageIcon),
      ),
    );
  }

  Widget _buildMealImage(String? imagePath, ColorScheme custom) {
    if (imagePath == null) {
      return _buildPlaceholderImage(custom);
    }

    if (imagePath.startsWith("http")) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholderImage(custom);
        },
      );
    } else {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholderImage(custom);
        },
      );
    }
  }

  void _showOptionsBottomSheet(BuildContext context, int actualMealKey) {
    final mealsBox = Hive.box<MealModel>('meals');
    final colors = Theme.of(context).colorScheme;
    final custom = colors;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: custom.apiMealCardBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: custom.switchInactiveText,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              meal.name,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: custom.areaCardText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
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
                  color: custom.areaCardText,
                ),
              ),
              subtitle: Text(
                'Edit meal information',
                style: TextStyle(fontSize: 14.sp, color: custom.secondaryText),
              ),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.updateMealScreen, extra: meal);
              },
            ),
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
                  color: custom.areaCardText,
                ),
              ),
              subtitle: Text(
                'Remove meal permanently',
                style: TextStyle(fontSize: 14.sp, color: custom.secondaryText),
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
    final colors = Theme.of(context).colorScheme;
    final custom = colors;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Row(
          children: [
            Icon(Icons.warning, color: custom.error, size: 24.sp),
            SizedBox(width: 8.w),
            Text(
              'Delete Meal',
              style: TextStyle(color: custom.areaCardText),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "${meal.name}"? This action cannot be undone.',
          style: TextStyle(fontSize: 16.sp, color: custom.areaCardText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: custom.switchInactiveText, fontSize: 16.sp),
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
                      backgroundColor: custom.error,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete meal: $e'),
                      backgroundColor: custom.error,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: custom.error,
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
