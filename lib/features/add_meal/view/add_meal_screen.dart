import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddMealScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
   AddMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _mealNameController,
              decoration: const InputDecoration(labelText: 'Meal Name'),
            ),
              SizedBox(height: 16.h),
            TextFormField(
              controller: _cookingTimeController,
              decoration: const InputDecoration(labelText: 'Cooking Time'),
            ),
              SizedBox(height: 16.h),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
              SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  GoRouter.of(context).pop();
                  // Process data.
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}