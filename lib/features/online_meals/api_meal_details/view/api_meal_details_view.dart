import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/theming/custom_colors.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/data/repo/api_meal_details_repo.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/manager/cubit/api_meal_details_cubit.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/manager/cubit/api_meal_details_state.dart';


import 'package:meal_mate/features/online_meals/mappers/api_meal_mapper.dart';

class ApiMealDetailScreen extends StatelessWidget {
  final String mealId;
  const ApiMealDetailScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApiMealDetailCubit(ApiMealDetailRepo())..getMealDetail(mealId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Meal Details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.apiMealDetailBackground,
        ),
        body: BlocBuilder<ApiMealDetailCubit, ApiMealDetailState>(
          builder: (context, state) {
            if (state is ApiMealDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ApiMealDetailLoaded) {
              final meal = state.mealDetail;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: SizedBox(
                        width: double.infinity,
                        height: 200.h,
                        child: Image.network(
                          meal.thumbnail,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.broken_image,
                            size: 80,
                            color: Theme.of(context).colorScheme.brokenImageIcon,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Center(
                      child: Text(
                        meal.name,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Instructions:",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      meal.instructions,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final box = Hive.box<MealModel>('meals');
                        final localMeal = meal.toLocalMeal();
                        await box.add(localMeal);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Meal saved locally!",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.download,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      label: Text(
                        "Save Locally",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ApiMealDetailError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

