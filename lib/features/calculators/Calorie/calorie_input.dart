import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/features/calculators/Calorie/calorie_output.dart';

import '../widgets/custom_calculator_text_field.dart';

class CalorieInputScreen extends StatefulWidget {
  const CalorieInputScreen({super.key});

  @override
  State<CalorieInputScreen> createState() => _CalorieInputScreenState();
}

class _CalorieInputScreenState extends State<CalorieInputScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String gender = "male".tr();
  String goal = "maintain_weight".tr();
  String activityLevel = "sedentary".tr();

  final List<String> activityLevels = [
    "sedentary".tr(),
    "lightly_active".tr(),
    "moderately_active".tr(),
    "very_active".tr(),
    "super_active".tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF65B741),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Calorie Calculator",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomCalculatorTextField(
              controller: ageController,
              hintText: "enter_your_age".tr(),
              inputType: TextInputType.number,
              label: "age".tr(),
            ),
            SizedBox(height: 25.h),
            CustomCalculatorTextField(
              controller: heightController,
              hintText: "enter_your_height".tr(),
              label: "height".tr(),
              inputType: TextInputType.number,
            ),
            SizedBox(height: 25.h),
            CustomCalculatorTextField(
              controller: weightController,
              hintText: "enter_your_weight".tr(),
              inputType: TextInputType.number,
              label: "weight".tr(),
            ),
            SizedBox(height: 25.h),
            DropdownButtonFormField<String>(
              value: gender,
              decoration: InputDecoration(
                labelText: "gender".tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              items:
                  ["male".tr(), "female".tr()].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (value) => setState(() => gender = value!),
            ),
            SizedBox(height: 25.h),
            DropdownButtonFormField<String>(
              value: goal,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: "goal".tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              items:
                  [
                    "lose_weight".tr(),
                    "maintain_weight".tr(),
                    "gain_weight".tr(),
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (value) => setState(() => goal = value!),
            ),

            SizedBox(height: 25.h),
            DropdownButtonFormField<String>(
              value: activityLevel,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: "activity_level".tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              items:
                  activityLevels.map((String level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
              onChanged: (value) => setState(() => activityLevel = value!),
            ),

            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CalorieOutputScreen(
                          age: int.tryParse(ageController.text) ?? 0,
                          height: double.tryParse(heightController.text) ?? 0.0,
                          weight: double.tryParse(weightController.text) ?? 0.0,
                          gender: gender,
                          goal: goal,
                          activityLevel: activityLevel,
                        ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF65B741),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                "calc".tr(),
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
