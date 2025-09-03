import 'package:flutter/material.dart';

class CustomCalculatorTextField extends StatelessWidget {
    final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final String label;
  const CustomCalculatorTextField({super.key,required this.hintText,
    required this.controller,
    required this.label,
    this.inputType = TextInputType.number,});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType, 
      decoration: InputDecoration(
        hintText: hintText,label: Text(label), 
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}