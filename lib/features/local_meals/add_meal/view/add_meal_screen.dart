import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/theming/app_colors.dart';
import 'package:meal_mate/core/theming/text_style.dart';

import 'package:meal_mate/features/local_meals/add_meal/manager/cubit/add_meal_cubit.dart';
import 'package:meal_mate/features/local_meals/add_meal/manager/cubit/add_meal_states.dart';
import 'package:meal_mate/features/local_meals/add_meal/view/widgets/add_meal_image.dart';
import 'package:meal_mate/features/local_meals/add_meal/view/widgets/add_meal_list_fields.dart';
import 'package:meal_mate/features/local_meals/add_meal/view/widgets/custom_appbar.dart';

import 'package:meal_mate/features/local_meals/add_meal/view/widgets/save_meal_button.dart';

class AddMealScreen extends StatefulWidget {
  AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  XFile? _selectedImage;

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.h),

                    // Image Picker Section
                    AddMealImage(
                      onImageSelected: (image) {
                        setState(() {
                          _selectedImage = image;
                        });
                      },
                      initialImage: _selectedImage,
                    ),

                    SizedBox(height: 24.h),

                    AddMealListFields(
                      mealNameController: _mealNameController,
                      cookingTimeController: _cookingTimeController,
                      descriptionController: _descriptionController,
                      ratingController: _ratingController,
                    ),
                    SizedBox(height: 40.h),
                    SaveMealButton(
                      isLoading: state is AddMealLoadingState,
                      backgroundColor: AppColors.orange,
                      textStyle: TextStyles.w600size14,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final meal = MealModel(
                            name: _mealNameController.text.trim(),
                            cookingTime: int.parse(
                              _cookingTimeController.text.trim(),
                            ),
                            description: _descriptionController.text.trim(),
                            rating: double.tryParse(
                                  _ratingController.text.trim(),
                                ) ??
                                0.0,
                            imagePath: _selectedImage?.path,
                          );
                          context.read<AddMealCubit>().addMeal(meal);
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
}