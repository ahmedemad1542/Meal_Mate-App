import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveMealButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String buttonText;
  final Color backgroundColor;
  final TextStyle textStyle;
  final double? width;
  final double? height;
  final double borderRadius;

  const SaveMealButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    this.buttonText = 'Save',
    required this.backgroundColor,
    required this.textStyle,
    this.width,
    this.height,
    this.borderRadius = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      child:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  minimumSize: Size(width ?? 327.w, height ?? 60.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: Text(buttonText, style: textStyle),
              ),
    );
  }
}
