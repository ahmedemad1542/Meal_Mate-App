import 'package:meal_mate/core/model/meal_model.dart';

abstract class AddMealStates {}

class AddMealInitialState extends AddMealStates {}  
class AddMealLoadingState extends AddMealStates {}
class AddMealSuccessState extends AddMealStates {
  final List<MealModel> meals;

  AddMealSuccessState(this.meals);
}
class AddMealErrorState extends AddMealStates {
  final String error;

  AddMealErrorState(this.error);
}