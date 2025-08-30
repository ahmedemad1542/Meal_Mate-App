import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/theming/app_colors.dart';
import 'package:meal_mate/features/local_meals/add_meal/view/widgets/custom_textform.dart';
import 'package:meal_mate/features/local_meals/update_meal/manager/cubit/update_meal_cubit.dart';
import 'package:meal_mate/features/local_meals/update_meal/manager/cubit/update_meal_states.dart';
import 'package:meal_mate/features/local_meals/update_meal/view/widgets/update_meal_image.dart';
import 'package:meal_mate/features/local_meals/update_meal/view/widgets/update_meals_buttons.dart';

class UpdateMealScreen extends StatefulWidget {
  final MealModel meal;
  final int mealKey;

  UpdateMealScreen({super.key, required this.meal, required this.mealKey});

  @override
  State<UpdateMealScreen> createState() => _UpdateMealScreenState();
}

class _UpdateMealScreenState extends State<UpdateMealScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _mealNameController;
  late final TextEditingController _cookingTimeController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _ratingController;
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    _mealNameController = TextEditingController(text: widget.meal.name);
    _cookingTimeController = TextEditingController(
      text: widget.meal.cookingTime.toString(),
    );
    _descriptionController = TextEditingController(
      text: widget.meal.description,
    );
    _ratingController = TextEditingController(
      text: widget.meal.rating.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: const Text(
          'Update Meal',
          style: TextStyle(color: AppColors.white),
        ),
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
            context.pop();
          } else if (state is UpdateMealErrorState) {
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
              child: SingleChildScrollView(
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
                          Icon(Icons.info, color: Colors.blue, size: 20.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Updating: ${widget.meal.name}',
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

                    
                    UpdateMealImage(
                      onImageSelected: (image) {
                        setState(() {
                          _selectedImage = image;
                        });
                      },
                      selectedImage: _selectedImage,
                      existingImagePath: widget.meal.imagePath,
                    ),

                    SizedBox(height: 24.h),

                    CustomTextFormField(
                      label: 'Meal Name',
                      controller: _mealNameController,
                      validator: (value) =>
                          value == null || value.isEmpty
                              ? "Enter meal name"
                              : null,
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
                          value == null || value.isEmpty
                              ? "Enter description"
                              : null,
                    ),

                    SizedBox(height: 16.h),

                    CustomTextFormField(
                      label: 'Rating',
                      controller: _ratingController,
                      keyboardType: TextInputType.number,
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

                    SizedBox(height: 32.h),

                    
                    UpdateMealButtons(
                      isLoading: state is UpdateMealLoadingState,
                      onCancel: () => context.pop(),
                      onUpdate: () {
                        if (_formKey.currentState!.validate()) {
                          final updatedMeal = MealModel(
                            id: widget.meal.id,
                            name: _mealNameController.text.trim(),
                            cookingTime: int.parse(
                              _cookingTimeController.text,
                            ),
                            description: _descriptionController.text.trim(),
                            imagePath: _selectedImage?.path ?? widget.meal.imagePath,
                            rating: double.tryParse(
                                  _ratingController.text,
                                ) ??
                                widget.meal.rating,
                          );

                          context
                              .read<UpdateMealCubit>()
                              .updateMealByKey(
                                widget.mealKey,
                                updatedMeal,
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _mealNameController.dispose();
    _cookingTimeController.dispose();
    _descriptionController.dispose();
    _ratingController.dispose();
    super.dispose();
  }
}