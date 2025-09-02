import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputHeaderText extends StatelessWidget {
  const InputHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Please Modify the values',
      style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
    );
  }
}
