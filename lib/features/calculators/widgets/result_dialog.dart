import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showResultDialog(
  BuildContext context,
  double bmi,
  int height,
  int weight,
  int age,
  String gender,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("your_bmi".tr(), style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(
              bmi.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Text( "height_result".tr(namedArgs: {"value": height.toString()})),
            Text("weight_result".tr(namedArgs: {"value": weight.toString()})),
            Text( "age_result".tr(namedArgs: {"value": age.toString()})),
            Text("gender_result".tr(namedArgs: {"value": gender})),
          ],
        ),
      );
    },
  );
}
