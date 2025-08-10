import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/core/theming/text_style.dart';

class CustomTextfield extends StatelessWidget {

  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final double? width;
  
  



  const CustomTextfield({super.key, this.hintText, required this.controller, this.label, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 327.w,
      child: TextField(
        
        controller: TextEditingController(),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          labelStyle: TextStyles.addMealDeatails,
          
          
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Color(0xffD6D6D6)),
          ),
        ),
        minLines: 1,
        maxLines: null,
        
        keyboardType: TextInputType.text,
        style: TextStyles.addMealDeatails
      ),
    );
  }
}