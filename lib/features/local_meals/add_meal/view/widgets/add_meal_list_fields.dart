import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/features/local_meals/add_meal/view/widgets/custom_textform.dart';

class AddMealListFields extends StatelessWidget {
  final TextEditingController mealNameController;
  final TextEditingController cookingTimeController;
  final TextEditingController descriptionController;
  final TextEditingController ratingController;

  const AddMealListFields({
    super.key,
    required this.mealNameController,
    required this.cookingTimeController,
    required this.descriptionController,
    required this.ratingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          label: 'Meal Name',
          controller: mealNameController,
          validator: (value) =>
              value == null || value.isEmpty ? "Enter meal name" : null,
        ),
        SizedBox(height: 30.h),
        CustomTextFormField(
          label: 'Cooking Time (minutes)',
          controller: cookingTimeController,
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
          controller: descriptionController,
          validator: (value) =>
              value == null || value.isEmpty ? "Enter description" : null,
        ),
        SizedBox(height: 30.h),
        CustomTextFormField(
          label: 'Rating',
          controller: ratingController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter rating";
            }

            final rating = double.tryParse(value);
            if (rating == null) {
              return "Enter a valid number";
            }

            if (rating < 0 || rating > 5) {
              return "Rating must be between 0 and 5";
            }

            return null;
          },
        ),
      ],
    );
  }
}
