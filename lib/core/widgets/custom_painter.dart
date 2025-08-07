import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    Path path =
        Path()
          ..moveTo(0, 0)
          ..lineTo(size.width * 0.30.w, 0)
          ..cubicTo(
            size.width * 0.45.w,
            0,
            size.width * 0.42.w,
            size.height * 0.6.h,
            size.width * 0.5.w,
            size.height * 0.6.h,
          )
          ..cubicTo(
            size.width * 0.58.w,
            size.height * 0.6.h,
            size.width * 0.55.w,
            0,
            size.width * 0.70.w, // بداية متأخرة للكيرف من اليمين
            0,
          )
          ..lineTo(size.width, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
