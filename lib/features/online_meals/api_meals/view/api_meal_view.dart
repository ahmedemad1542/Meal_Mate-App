import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/online_meals/api_meals/manager/cubit/api_meals_cubit.dart';
import 'package:meal_mate/features/online_meals/api_meals/manager/cubit/api_meals_state.dart';

class MealsScreen extends StatelessWidget {
  final String category;
  const MealsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiMealCubit, ApiMealState>(
      builder: (context, state) {
        if (state is ApiMealLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ApiMealLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: state.meals.length,
            itemBuilder: (context, index) {
              final meal = state.meals[index];
              return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(meal.thumbnail, height: 60),
                    const SizedBox(height: 8),
                    Text(meal.name),
                  ],
                ),
              );
            },
          );
        } else if (state is ApiMealError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}