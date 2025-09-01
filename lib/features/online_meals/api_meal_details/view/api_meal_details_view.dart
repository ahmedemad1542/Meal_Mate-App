import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/data/repo/api_meal_details_repo.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/manager/cubit/api_meal_details_cubit.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/manager/cubit/api_meal_details_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/online_meals/mappers/api_meal_mapper.dart';

class ApiMealDetailScreen extends StatelessWidget {
  final String mealId;
  const ApiMealDetailScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => ApiMealDetailCubit(ApiMealDetailRepo())..getMealDetail(mealId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Meal Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
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
                          errorBuilder:
                              (context, error, stackTrace) => const Icon(
                                Icons.broken_image,
                                size: 80,
                                color: Colors.grey,
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
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Instructions:",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(meal.instructions, style: TextStyle(fontSize: 16.sp)),
                    SizedBox(height: 12.h),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final box = Hive.box<MealModel>('meals');
                        final localMeal = meal.toLocalMeal();
                        await box.add(localMeal);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Meal saved locally!")),
                        );
                      },
                      icon: const Icon(Icons.download),
                      label: const Text("Save Locally"),
                    ),
                  ],
                ),
              );
            } else if (state is ApiMealDetailError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
