import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/core/theming/custom_colors.dart';
import 'package:meal_mate/features/online_meals/category_feature/manager/cubit/category_cubit.dart';
import 'package:meal_mate/features/online_meals/category_feature/manager/cubit/category_state.dart';
import 'package:meal_mate/features/online_meals/category_feature/widgets/category_grid.dart';

class ApiCategoriesScreen extends StatelessWidget {
  final String area;
  const ApiCategoriesScreen({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories in $area",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colors.appBarText,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return CategoryGrid(area: area, categories: state.categories);
          } else if (state is CategoryError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: colors.errorText),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
