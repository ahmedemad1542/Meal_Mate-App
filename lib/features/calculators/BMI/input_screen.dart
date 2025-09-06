import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/features/calculators/widgets/height_picker_box.dart';
import 'package:meal_mate/features/calculators/widgets/input_box.dart';
import 'package:meal_mate/features/calculators/widgets/result_dialog.dart';

class InputScreen extends StatefulWidget {
  final String gender;
  const InputScreen({super.key, required this.gender});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  int age = 20;
  int weight = 65;
  int height = 170;
  late RulerPickerController _rulerPickerController;

  @override
  void initState() {
    super.initState();
    _rulerPickerController = RulerPickerController(value: height.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* const InputHeaderText(),*/
              SizedBox(height: 40.h),
              Text(
                "modify_values".tr(),
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputBox(
                    label: "weight".tr(),
                    value: weight,
                    onIncrement: () => setState(() => weight++),
                    onDecrement:
                        () => setState(() {
                          if (weight > 0) weight--;
                        }),
                  ),
                  SizedBox(width: 30.w),
                  InputBox(
                    label: "age".tr(),
                    value: age,
                    onIncrement: () => setState(() => age++),
                    onDecrement:
                        () => setState(() {
                          if (age > 0) age--;
                        }),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              HeightPickerBox(
                height: height,
                controller: _rulerPickerController,
                onChanged: (val) => setState(() => height = val),
              ),
              SizedBox(height: 50.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF65B741),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: const Size(340, 70),
                ),
                onPressed: () {
                  double bmi = weight / ((height / 100) * (height / 100));
                  showResultDialog(
                    context,
                    bmi,
                    height,
                    weight,
                    age,
                    widget.gender,
                  );
                },
                child:  Text(
                  "calc".tr(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
