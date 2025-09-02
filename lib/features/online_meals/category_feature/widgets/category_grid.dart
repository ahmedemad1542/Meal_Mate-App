import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/online_meals/category_feature/data/model/category_model.dart';
import 'package:meal_mate/features/online_meals/category_feature/widgets/category_card.dart';

import '../manager/cubit/category_cubit.dart';

class CategoryGrid extends StatelessWidget {
  final String area;
  final List<CategoryModel> categories;

  const CategoryGrid({
    super.key,
    required this.area,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<CategoryCubit>().getCategories(forceRefresh: true);
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryCard(area: area, category: category);
        },
      ),
    );
  }
}