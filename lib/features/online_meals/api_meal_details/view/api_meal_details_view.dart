import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/data/repo/api_meal_details_repo.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/manager/cubit/api_meal_details_cubit.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/manager/cubit/api_meal_details_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ApiMealDetailScreen extends StatelessWidget {
  final String mealId;
  const ApiMealDetailScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApiMealDetailCubit(ApiMealDetailRepo())..getMealDetail(mealId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Meal Details"),
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
                    Image.network(meal.thumbnail),
                    const SizedBox(height: 16),
                    Text(
                      meal.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Instructions:",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(meal.instructions),
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
