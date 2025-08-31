import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/core/theming/app_colors.dart';
import 'package:meal_mate/features/online_meals/api_meals/manager/cubit/api_meals_cubit.dart';
import 'package:meal_mate/features/online_meals/api_meals/manager/cubit/api_meals_state.dart';
import 'package:go_router/go_router.dart';

class ApiMealsScreen extends StatefulWidget {
  final String area;
  final String category;

  const ApiMealsScreen({super.key, required this.area, required this.category});

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
        title: Text(
          " (${widget.category}, ${widget.area})",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
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
                mainAxisSpacing: 20,
                crossAxisSpacing: 15,
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            meal.thumbnail,
                            height: 100.h,
                            width: 100.w,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => const Icon(
                                  Icons.broken_image,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            meal.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
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
