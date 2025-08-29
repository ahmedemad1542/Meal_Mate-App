import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/features/online_meals/area_feature/manager/cubit/area_cubit.dart';
import 'package:meal_mate/features/online_meals/area_feature/manager/cubit/area_state.dart';
import 'package:go_router/go_router.dart';


class AreasScreen extends StatelessWidget {
  const AreasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AreaCubit, AreaState>(
      builder: (context, state) {
        if (state is AreaLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AreaLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: state.areas.length,
            itemBuilder: (context, index) {
              final area = state.areas[index];
              return GestureDetector(onTap: () {
                context.pushNamed(AppRoutes.categoryMealsScreen, extra: area.name);
              },
                child: Card(
                  child: Center(child: Text(area.name)),
                ),
              );
            },
          );
        } else if (state is AreaError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}