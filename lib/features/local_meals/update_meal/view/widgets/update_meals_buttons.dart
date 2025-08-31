import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/core/theming/app_colors.dart';

class UpdateMealButtons extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onCancel;
  final VoidCallback onUpdate;
  final String updateButtonText;
  final String cancelButtonText;

  const UpdateMealButtons({
    super.key,
    required this.isLoading,
    required this.onCancel,
    required this.onUpdate,
    this.updateButtonText = 'Update Meal',
    this.cancelButtonText = 'Cancel',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Cancel Button
        Expanded(
          child: ElevatedButton(
            onPressed: onCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              cancelButtonText,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        SizedBox(width: 16.w),

        // Update Button
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: isLoading ? null : onUpdate,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child:
                isLoading
                    ? SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: const CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 3,
                      ),
                    )
                    : Text(
                      updateButtonText,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
          ),
        ),
      ],
    );
  }
}
