import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/features/meals/add_meal/view/widgets/custom_textform.dart';
import 'package:meal_mate/features/meals/update_meal/manager/cubit/update_meal_cubit.dart';
import 'package:meal_mate/features/meals/update_meal/manager/cubit/update_meal_states.dart';

class UpdateMealScreen extends StatelessWidget {
  final MealModel meal;
  final int mealKey;

  UpdateMealScreen({
    super.key,
    required this.meal,
    required this.mealKey,
  });

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _mealNameController = 
      TextEditingController(text: meal.name);
  late final TextEditingController _cookingTimeController = 
      TextEditingController(text: meal.cookingTime.toString());
  late final TextEditingController _descriptionController = 
      TextEditingController(text: meal.describtion);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Meal'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<UpdateMealCubit, UpdateMealState>(
       listener: (context, state) {
  if (state is UpdateMealSuccessState) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message),
        backgroundColor: Colors.green,
      ),
    );
    context.pop(); // هيرجع بعد التحديث
  } else if (state is UpdateMealErrorState) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.error),
        backgroundColor: Colors.red,
      ),
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
                  // Current meal preview
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.blue.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: Colors.blue,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Updating: ${meal.name}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  CustomTextFormField(
                    label: 'Meal Name',
                    controller: _mealNameController,
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter meal name" : null,
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  CustomTextFormField(
                    label: 'Cooking Time (minutes)',
                    controller: _cookingTimeController,
                    keyboardType: TextInputType.number,
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
                  
                  SizedBox(height: 16.h),
                  
                  CustomTextFormField(
                    label: 'Description',
                    controller: _descriptionController,
                    maxLines: 3,
                    validator: (value) =>
                        value == null || value.isEmpty ? "Enter description" : null,
                  ),
                  
                  SizedBox(height: 32.h),
                  
                  // Update and Cancel Buttons
                  Row(
                    children: [
                      // Cancel Button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            side: BorderSide(color: Colors.grey[400]!),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: 16.w),
                      
                      // Update Button
                      Expanded(
                        flex: 2,
                        child: state is UpdateMealLoadingState
                            ? Container(
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final updatedMeal = MealModel(
                                      id: meal.id,
                                      name: _mealNameController.text.trim(),
                                      cookingTime: int.parse(_cookingTimeController.text),
                                      describtion: _descriptionController.text.trim(),
                                      imagePath: meal.imagePath,
                                      rating:  meal.rating,
                                    );
                                    
                                    context.read<UpdateMealCubit>().updateMealByKey(
                                      (mealKey),
                                      updatedMeal,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                child: Text(
                                  'Update Meal',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                      ),
                    ],
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
