import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final int maxVisibleLines;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.maxVisibleLines = 5, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxVisibleLines * 24.0 + 24.0,
          
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true,
            child: TextFormField(
              controller: controller,
              minLines: 1,
              maxLines: null, // بيتمدد مع الكلام
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: hintText,
              ),
              validator: validator,
            ),
          ),
        ),
      ),
    );
  }
}
