import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomInputAppBar extends StatelessWidget {
  const CustomInputAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset("assets/icons/arrow_back.svg"),
          ),
          Expanded(
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w600),
                  children: const [
                    TextSpan(
                      text: 'BMI ',
                      style: TextStyle(color: Color(0xFFFFB534)),
                    ),
                    TextSpan(
                      text: 'Calculator',
                      style: TextStyle(color: Color(0xFF65B741)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
