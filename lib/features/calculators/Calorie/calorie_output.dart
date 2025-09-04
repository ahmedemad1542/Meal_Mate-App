import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CalorieOutputScreen extends StatelessWidget {
  final int age;
  final double height;
  final double weight;
  final String gender;     
  final String goal;        
  final String activityLevel; 

  const CalorieOutputScreen({
    super.key,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.goal,
    required this.activityLevel,
  });

  double calculateBMR() {
    if (gender == "male") {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  double getActivityFactor() {
    switch (activityLevel) {
      case "sedentary":
        return 1.2;
      case "lightly_active":
        return 1.375;
      case "moderately_active":
        return 1.55;
      case "very_active":
        return 1.725;
      case "super_active":
        return 1.9;
      default:
        return 1.2;
    }
  }

  double calculateTDEE() {
    final bmr = calculateBMR();
    final tdee = bmr * getActivityFactor();

    switch (goal) {
      case "lose_weight":
        return tdee - 500;
      case "gain_weight":
        return tdee + 500;
      case "maintain_weight":
      default:
        return tdee;
    }
  }

  @override
  Widget build(BuildContext context) {
    final calories = calculateTDEE().round();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "calorie_message".tr(
              namedArgs: {
                "calories": calories.toString(),
                "goal": goal.tr(), 
              },
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

