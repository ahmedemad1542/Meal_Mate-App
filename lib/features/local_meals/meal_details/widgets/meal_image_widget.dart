import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealImageWidget extends StatelessWidget {
  final String? imagePath;

  const MealImageWidget({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey[300],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: _buildMealImage(imagePath),
      ),
    );
  }

  Widget _buildMealImage(String? path) {
    if (path == null) {
      return Icon(Icons.restaurant_menu, size: 60.sp, color: Colors.grey[600]);
    }
    if (path.startsWith("http")) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Icon(Icons.broken_image, size: 60.sp, color: Colors.grey[600]),
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Icon(Icons.broken_image, size: 60.sp, color: Colors.grey[600]),
      );
    }
  }
}
