import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/features/meals/add_meal/view/widgets/custom_textform.dart';

class AddMealListFields extends StatelessWidget {
   final _formKey = GlobalKey<FormState>();
  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

   AddMealListFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         CustomTextFormField(
                    label: 'Meal Name',
                    controller: _mealNameController,
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter meal name"
                                : null,
                  ),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                    label: 'Cooking Time (minutes)',
                    controller: _cookingTimeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter cooking time";
                      }
                      if (int.tryParse(value) == null) {
                        return "Enter a valid number";
                      }
                      if (int.parse(value) <= 0) {
                        return "Cooking time must be greater than 0";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                    label: 'Description',
                    controller: _descriptionController,
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter description"
                                : null,
                  ),
      ],
    );
  }
}