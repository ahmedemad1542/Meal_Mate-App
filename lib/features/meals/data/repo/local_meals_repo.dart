

import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_mate/core/model/meal_model.dart';

class LocalMealsRepo {
  final Box<MealModel> _box = Hive.box<MealModel>('meals');

  // add meal
  Future<void> addMeal(MealModel meal) async => await _box.add(meal);

  // get all meals
  List<MealModel> getLocalMeals() => _box.values.toList();

  // update meal
  Future<void> updateMeal(MealModel meal) async => await meal.save();

  // delete meal
  Future<void> deleteMeal(MealModel meal) async => await meal.delete();

  // get meal by key
  MealModel? getMeal(int key) => _box.get(key);

  // delete meal by key
  Future<void> deleteMealByKey(int key) async => await _box.delete(key);

  // update meal by key
  Future<void> updateMealByKey(int key, MealModel meal) async => 
      await _box.put(key, meal);

  // clear all meals
  Future<void> clearAllMeals() async => await _box.clear();

  // get meals count
  int get mealsCount => _box.length;
}