import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/widgets/meal_card/view/meal_card.dart';

class GridviewMealcard extends StatelessWidget {
  const GridviewMealcard({super.key});

  @override
  Widget build(BuildContext context) {
    final mealsBox = Hive.box<MealModel>('meals');

    return ValueListenableBuilder(
      valueListenable: mealsBox.listenable(),
      builder: (context, Box<MealModel> box, _) {
        final meals = box.values.toList();
        final keys = box.keys.toList();

        if (meals.isEmpty) {
          return SizedBox(
            height: 0.5.sh,
            child: const Center(
              child: Text(
                "You don't have any\n saved meals yet\n press the add button\n to add a new meal",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: meals.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 44,
            crossAxisSpacing: 30,
            childAspectRatio: 160 / 210,
          ),
          itemBuilder: (context, index) {
            return MealCard(meal: meals[index], mealKey: keys[index] as int);
          },
        );
      },
    );
  }
}
