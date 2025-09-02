import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealNameWidget extends StatelessWidget {
  final String name;

  const MealNameWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
