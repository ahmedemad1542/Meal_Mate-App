import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/theming/app_colors.dart';
import 'package:meal_mate/features/meals/add_meal/view/widgets/custom_textform.dart';
import 'package:meal_mate/features/meals/update_meal/manager/cubit/update_meal_cubit.dart';
import 'package:meal_mate/features/meals/update_meal/manager/cubit/update_meal_states.dart';

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
    _cookingTimeController = TextEditingController(text: widget.meal.cookingTime.toString());
    _descriptionController = TextEditingController(text: widget.meal.description);
    _ratingController = TextEditingController(text: widget.meal.rating.toString());
  }

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

                    // Image Update Section
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
                          Row(
                            children: [
                              Text(
                                'Meal Image',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Spacer(),
                              TextButton.icon(
                                onPressed: () => _showImageSourceDialog(context),
                                icon: Icon(Icons.edit, size: 16.sp),
                                label: Text('Change'),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.orange,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          
                          // Show selected image, new image, or default placeholder
                          Container(
                            height: 150.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: Colors.grey.withOpacity(0.3)),
                            ),
                            child: _buildImageDisplay(),
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
                                        id: widget.meal.id,
                                        name: _mealNameController.text.trim(),
                                        cookingTime: int.parse(
                                          _cookingTimeController.text,
                                        ),
                                        description: _descriptionController.text.trim(),
                                        imagePath: _selectedImage?.path ?? widget.meal.imagePath,
                                        rating: double.tryParse(
                                              _ratingController.text,
                                            ) ?? widget.meal.rating,
                                      );

                                      context
                                          .read<UpdateMealCubit>()
                                          .updateMealByKey(
                                            widget.mealKey,
                                            updatedMeal,
                                          );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.h,
                                    ),
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageDisplay() {
    // If new image is selected, show it
    if (_selectedImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.file(
          File(_selectedImage!.path),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      );
    }
    
    // If meal has existing image, show it
    if (widget.meal.imagePath != null && widget.meal.imagePath!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.file(
          File(widget.meal.imagePath!),
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder();
          },
        ),
      );
    }
    
    // Show placeholder if no image
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 40.sp,
            color: Colors.grey[600],
          ),
          SizedBox(height: 8.h),
          Text(
            'No Image Selected',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Tap "Change" to add photo',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
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
                    _ImageSourceOption(
                      icon: Icons.camera_alt,
                      label: 'Camera',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImageFromSource(ImageSource.camera);
                      },
                    ),
                    _ImageSourceOption(
                      icon: Icons.photo_library,
                      label: 'Gallery',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImageFromSource(ImageSource.gallery);
                      },
                    ),
                    if (widget.meal.imagePath != null || _selectedImage != null)
                      _ImageSourceOption(
                        icon: Icons.delete_outline,
                        label: 'Remove',
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _selectedImage = null;
                          });
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

  @override
  void dispose() {
    _mealNameController.dispose();
    _cookingTimeController.dispose();
    _descriptionController.dispose();
    _ratingController.dispose();
    super.dispose();
  }
}

class _ImageSourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ImageSourceOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28.sp,
              color: icon == Icons.delete_outline ? Colors.red : AppColors.orange,
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: icon == Icons.delete_outline ? Colors.red : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
