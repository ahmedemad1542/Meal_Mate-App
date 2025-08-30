import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/features/online_meals/api_meals/manager/cubit/api_meals_cubit.dart';
import 'package:meal_mate/features/online_meals/api_meals/manager/cubit/api_meals_state.dart';
import 'package:go_router/go_router.dart';


class ApiMealsScreen extends StatefulWidget {
  final String area;
  final String category;

  const ApiMealsScreen({
    super.key,
    required this.area,
    required this.category,
  });

  @override
  State<ApiMealsScreen> createState() => _ApiMealsScreenState();
}

class _ApiMealsScreenState extends State<ApiMealsScreen> {
  @override
  void initState() {
    super.initState();
    
    final cubit = context.read<ApiMealCubit>();
    cubit.getMealsByCategory(widget.category);
    cubit.getMealsByArea(widget.area);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meals (${widget.category}, ${widget.area})"),
        centerTitle: true,
      ),
      body: BlocBuilder<ApiMealCubit, ApiMealState>(
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
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.apimealdetailsscreen,
                      extra: meal.id,
                    );
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(meal.thumbnail, height: 60),
                        const SizedBox(height: 8),
                        Text(meal.name),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ApiMealError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
