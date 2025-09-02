import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealDescriptionWidget extends StatelessWidget {
  final String description;

  const MealDescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            description,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ),
      ),
    );
  }
}
