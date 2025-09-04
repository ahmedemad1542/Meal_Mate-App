import 'package:easy_localization/easy_localization.dart';
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
          label:"meal_name".tr(),
          controller: mealNameController,
          validator: (value) =>
              value == null || value.isEmpty ?"enter_meal_name".tr() : null,
        ),
        SizedBox(height: 30.h),
        CustomTextFormField(
          label: "cooking_time".tr(),
          controller: cookingTimeController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "enter_cooking_time".tr();
            }
            if (int.tryParse(value) == null) {
              return "enter_valid_number".tr();
            }
            if (int.parse(value) <= 0) {
              return"cooking_time_greater_than_zero".tr();
            }
            return null;
          },
        ),
        SizedBox(height: 30.h),
        CustomTextFormField(
          label: "discription".tr(),
          controller: descriptionController,
          validator: (value) =>
              value == null || value.isEmpty ? "Enter description".tr() : null,
        ),
        SizedBox(height: 30.h),
        CustomTextFormField(
          label:  "rating".tr(),
          controller: ratingController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "enter_rating".tr();
            }

            final rating = double.tryParse(value);
            if (rating == null) {
              return "enter_valid_number".tr();
            }

            if (rating < 0 || rating > 5) {
              return "rating_must_be_between_0_and_5".tr();
            }

            return null;
          },
        ),
      ],
    );
  }
}
