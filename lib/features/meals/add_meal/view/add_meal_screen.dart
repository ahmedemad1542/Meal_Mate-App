import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/features/meals/add_meal/manager/cubit/add_meal_cubit.dart';
import 'package:meal_mate/features/meals/add_meal/manager/cubit/add_meal_states.dart';

class AddMealScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AddMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddMealCubit, AddMealState>(
        listener: (context, state) {
          if (state is AddMealSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            GoRouter.of(context).pop(); // يرجع بعد الحفظ
          } else if (state is AddMealErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
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
                  TextFormField(
                    controller: _mealNameController,
                    decoration: const InputDecoration(labelText: 'Meal Name'),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter meal name" : null,
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _cookingTimeController,
                    decoration: const InputDecoration(labelText: 'Cooking Time'),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter cooking time" : null,
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter description" : null,
                  ),
                  SizedBox(height: 32.h),
                  state is AddMealLoadingState
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final meal = MealModel(
                                name: _mealNameController.text,
                                cookingTime:
                                    int.parse(_cookingTimeController.text),
                                describtion: _descriptionController.text,
                              );

                              context.read<AddMealCubit>().addMeal(meal);
                            }
                          },
                          child: const Text('Save'),
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