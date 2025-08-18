import 'package:flutter/widgets.dart';
import 'package:meal_mate/core/widgets/meal_card.dart';

class GridviewMealcard extends StatelessWidget {
  const GridviewMealcard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 44,
                crossAxisSpacing: 30,
                childAspectRatio: 160 / 210,
              ),
              itemBuilder: (context, index) => const MealCard(),
            );
  }
}