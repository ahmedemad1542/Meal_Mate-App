import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class SaveMealButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String? buttonText;
  final Color backgroundColor;
  final TextStyle textStyle;
  final double? width;
  final double? height;
  final double borderRadius;

  const SaveMealButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    this.buttonText,
    required this.backgroundColor,
    required this.textStyle,
    this.width,
    this.height,
    this.borderRadius = 100,
  });

  String _capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    
    final rawText = buttonText?.tr() ?? "save".tr();
    final text = _capitalize(rawText); 

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                minimumSize: Size(width ?? 327.w, height ?? 60.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                textStyle: textStyle,
              ),
              child: Text(text, style: textStyle),
            ),
    );
  }
}
