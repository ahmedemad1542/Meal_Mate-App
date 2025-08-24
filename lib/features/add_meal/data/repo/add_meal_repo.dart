import 'package:hive/hive.dart';
import 'package:meal_mate/core/model/meal_model.dart';

class AddMealRepo {
  final Box<MealModel> _box = Hive.box<MealModel>('meals');
  Future<void> addMeal(MealModel meal) async {
    await _box.add(meal);
  }
  List<MealModel> getMeals() {
    return _box.values.toList();
  }
}