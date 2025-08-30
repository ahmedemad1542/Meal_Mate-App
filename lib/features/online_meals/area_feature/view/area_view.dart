import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meal_mate/core/constants/country_codes.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/features/online_meals/area_feature/manager/cubit/area_cubit.dart';
import 'package:meal_mate/features/online_meals/area_feature/manager/cubit/area_state.dart';
import 'package:go_router/go_router.dart';
import 'package:country_icons/country_icons.dart';




class AreasScreen extends StatelessWidget {
  const AreasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AreaCubit, AreaState>(
      builder: (context, state) {
        if (state is AreaLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AreaLoaded) {
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
              itemCount: state.areas.length,
              itemBuilder: (context, index) {
                final area = state.areas[index];
                final code = CountryCodes.map[area.name];

                return GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.categoryMealsScreen,
                      extra: area.name,
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (code != null)
                          SvgPicture.asset(
                            'icons/flags/svg/$code.svg',
                            package: 'country_icons',
                            width: 48,
                            height: 48,
                          )
                        else
                          const Icon(Icons.flag, size: 48, color: Colors.grey),
                        const SizedBox(height: 8),
                        Text(
                          area.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is AreaError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}