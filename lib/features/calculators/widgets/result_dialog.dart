import 'package:flutter/material.dart';

void showResultDialog(BuildContext context, double bmi, int height, int weight, int age, String gender) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Your BMI:", style: TextStyle(fontSize: 18)),
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
            Text("Height: $height cm"),
            Text("Weight: $weight kg"),
            Text("Age: $age"),
            Text("Gender: $gender"),
          ],
        ),
      );
    },
  );
}
