import 'package:flutter/material.dart';

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
          ..lineTo(size.width * 0.28, 0)
          ..cubicTo(
            size.width * 0.42,
            0, // نقطة تحكم أولى (للانسيابية من البداية)
            size.width * 0.42,
            size.height * 0.6, // نقطة تحكم ثانية (عمق الكيرف)
            size.width * 0.5,
            size.height * 0.6, // منتصف الكيرف
          )
          ..cubicTo(
            size.width * 0.58,
            size.height * 0.6, // نقطة تحكم ثالثة (بعد النص)
            size.width * 0.58,
            0, // نقطة تحكم رابعة (للرجوع بانسيابية)
            size.width * 0.70,
            0, // نهاية الكيرف
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
