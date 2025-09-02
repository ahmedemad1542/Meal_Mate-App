import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputBox extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const InputBox({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: const Color(0xffFBF6EE),
      ),
      child: Column(
        children: [
          SizedBox(height: 25.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xffACACAC),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 13.h),
          Text(
            '$value',
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xffCE922A),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _circleButton(Icons.add, onIncrement),
              SizedBox(width: 30.w),
              _circleButton(Icons.remove, onDecrement),
            ],
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: IconButton(
        icon: Icon(icon, color: Color(0xff9D6F1F), size: 25.sp),
        onPressed: onPressed,
      ),
    );
  }
}
