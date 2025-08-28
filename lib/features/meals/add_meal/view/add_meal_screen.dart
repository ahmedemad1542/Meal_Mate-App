import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/theming/app_colors.dart';
import 'package:meal_mate/core/theming/text_style.dart';
import 'package:meal_mate/core/widgets/image_manager/image_manager_view.dart';
import 'package:meal_mate/features/meals/add_meal/manager/cubit/add_meal_cubit.dart';
import 'package:meal_mate/features/meals/add_meal/manager/cubit/add_meal_states.dart';
import 'package:meal_mate/features/meals/add_meal/view/widgets/add_meal_list_fields.dart';
import 'package:meal_mate/features/meals/add_meal/view/widgets/custom_appbar.dart';
import 'package:meal_mate/features/meals/add_meal/view/widgets/image_source_option.dart';

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
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Meal Image',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          ImageManagerView(
                            onPicked: (image) {
                              setState(() {
                                _selectedImage = image;
                              });
                            },
                            pickedBody:
                                (image) => Container(
                                  height: 150.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    image: DecorationImage(
                                      image: FileImage(File(image.path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.6,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed:
                                                () => _showImageSourceDialog(
                                                  context,
                                                ),
                                            icon: Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 20.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            unPickedBody: Container(
                              height: 120.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: 40.sp,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Add Meal Photo',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Tap to choose from gallery or camera',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    AddMealListFields(
                      mealNameController: _mealNameController,
                      cookingTimeController: _cookingTimeController,
                      descriptionController: _descriptionController,
                      ratingController: _ratingController,
                    ),
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
                                        _cookingTimeController.text.trim(),
                                      ),
                                      description:
                                          _descriptionController.text.trim(),
                                      rating:
                                          double.tryParse(
                                            _ratingController.text.trim(),
                                          ) ??
                                          0.0,
                                      imagePath:
                                          _selectedImage
                                              ?.path, // Add image path
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
                                child: Text(
                                  'Save',
                                  style: TextStyles.w600size14,
                                ),
                              ),
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

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Image Source',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ImageSourceOption(
                      // Remove the underscore
                      icon: Icons.camera_alt,
                      label: 'Camera',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImageFromSource(ImageSource.camera);
                      },
                    ),
                    ImageSourceOption(
                      // Remove the underscore
                      icon: Icons.photo_library,
                      label: 'Gallery',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImageFromSource(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickImageFromSource(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }
}
