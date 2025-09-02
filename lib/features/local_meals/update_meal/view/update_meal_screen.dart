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
import 'package:meal_mate/features/local_meals/update_meal/view/widgets/update_meal_appbar.dart';
import 'package:meal_mate/features/local_meals/update_meal/view/widgets/update_meal_form_fields.dart';
import 'package:meal_mate/features/local_meals/update_meal/view/widgets/update_meal_image.dart';
import 'package:meal_mate/features/local_meals/update_meal/view/widgets/update_meal_indo_banner.dart';
import 'package:meal_mate/features/local_meals/update_meal/view/widgets/update_meals_buttons.dart';

class UpdateMealScreen extends StatefulWidget {
  final MealModel meal;
  final int mealKey;

  const UpdateMealScreen({
    super.key,
    required this.meal,
    required this.mealKey,
  });

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
    _cookingTimeController =
        TextEditingController(text: widget.meal.cookingTime.toString());
    _descriptionController =
        TextEditingController(text: widget.meal.description);
    _ratingController =
        TextEditingController(text: widget.meal.rating.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UpdateMealAppBar(),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UpdateMealInfoBanner(mealName: widget.meal.name),
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

                    UpdateMealFormFields(
                      mealNameController: _mealNameController,
                      cookingTimeController: _cookingTimeController,
                      descriptionController: _descriptionController,
                      ratingController: _ratingController,
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
                            imagePath: _selectedImage?.path ??
                                widget.meal.imagePath,
                            rating: double.tryParse(
                                  _ratingController.text,
                                ) ??
                                widget.meal.rating,
                          );

                          context
                              .read<UpdateMealCubit>()
                              .updateMealByKey(widget.mealKey, updatedMeal);
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