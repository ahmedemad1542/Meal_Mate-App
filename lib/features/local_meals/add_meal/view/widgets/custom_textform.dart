import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.minLines = 1,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327.w,
      height: 80.h,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines ?? null,
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.0.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: BorderSide(color: Colors.red, width: 2.0.w),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
