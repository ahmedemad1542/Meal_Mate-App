import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/data/model/api_meal_details_model.dart';

extension ApiMealMapper on ApiMealDetailModel {

  MealModel toLocalMeal() {

    return MealModel(
      name: name,
      cookingTime: 0, 
      description: instructions,
      imagePath: thumbnail, 
      rating: 0.0,
    );
  }
}