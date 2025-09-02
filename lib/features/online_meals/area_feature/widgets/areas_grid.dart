import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/constants/country_codes.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/features/online_meals/area_feature/data/model/area_model.dart';
import 'package:meal_mate/features/online_meals/area_feature/manager/cubit/area_cubit.dart';
import 'package:meal_mate/features/online_meals/area_feature/widgets/area_card.dart';

class AreasGrid extends StatelessWidget {
  final List<AreaModel> areas;

  const AreasGrid({super.key, required this.areas});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<AreaCubit>().getAreas(forceRefresh: true);
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: areas.length,
        itemBuilder: (context, index) {
          final area = areas[index];
          final code = CountryCodes.map[area.name];

          return AreaCard(
            name: area.name,
            code: code,
            onTap: () {
              context.pushNamed(
                AppRoutes.categoryMealsScreen,
                extra: area.name,
              );
            },
          );
        },
      ),
    );
  }
}
