import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeightPickerBox extends StatelessWidget {
  final int height;
  final RulerPickerController controller;
  final ValueChanged<int> onChanged;

  const HeightPickerBox({
    super.key,
    required this.height,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361.w,
      height: 213.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: const Color(0xffFBF6EE),
      ),
      child: Column(
        children: [
          SizedBox(height: 25.h),
          Text(
            "height".tr(),
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xffACACAC),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            '$height',
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xffCE922A),
            ),
          ),
          SizedBox(
            width: 320.w,
            height: 58.h,
            child: RulerPicker(
              controller: controller,
              onValueChanged: (value) => onChanged(value.toInt() - 2),
              onBuildRulerScaleText: (index, value) => value.toInt().toString(),
              ranges: const [RulerRange(begin: 100, end: 250, scale: 1)],
              scaleLineStyleList: const [
                ScaleLineStyle(
                  color: Color(0xffC4C4C4),
                  width: 1.5,
                  height: 50,
                  scale: 0,
                ),
                ScaleLineStyle(
                  color: Colors.grey,
                  width: 1,
                  height: 20,
                  scale: 5,
                ),
                ScaleLineStyle(
                  color: Colors.grey,
                  width: 1,
                  height: 10,
                  scale: -1,
                ),
              ],
              width: MediaQuery.of(context).size.width,
              height: 80,
              rulerMarginTop: 8,
            ),
          ),
        ],
      ),
    );
  }
}
