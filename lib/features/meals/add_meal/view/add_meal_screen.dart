import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/theming/app_colors.dart';
import 'package:meal_mate/core/theming/text_style.dart';
import 'package:meal_mate/features/meals/add_meal/manager/cubit/add_meal_cubit.dart';
import 'package:meal_mate/features/meals/add_meal/manager/cubit/add_meal_states.dart';
import 'package:meal_mate/features/meals/add_meal/view/widgets/add_meal_list_fields.dart';
import 'package:meal_mate/features/meals/add_meal/view/widgets/custom_appbar.dart';
import 'package:meal_mate/features/meals/add_meal/view/widgets/custom_textform.dart';

class AddMealScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AddMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppbar(),
      body: BlocConsumer<AddMealCubit, AddMealState>(
        listener: (context, state) {
          if (state is AddMealSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            GoRouter.of(context).pop();
          } else if (state is AddMealErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                 AddMealListFields(),
                  SizedBox(height: 40.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child:
                        state is AddMealLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final meal = MealModel(
                                    name: _mealNameController.text.trim(),
                                    cookingTime: int.parse(
                                      _cookingTimeController.text,
                                    ),
                                    describtion:
                                        _descriptionController.text.trim(),
                                  );
                                  context.read<AddMealCubit>().addMeal(meal);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.orange,
                                minimumSize: Size(327.w, 52.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Text('Save', style: TextStyles.w600size14),
                            ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
