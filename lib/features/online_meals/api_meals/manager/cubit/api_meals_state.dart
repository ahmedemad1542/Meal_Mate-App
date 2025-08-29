import 'package:meal_mate/features/online_meals/api_meals/data/model/api_meals_repo.dart';

abstract class ApiMealState {}

class ApiMealInitial extends ApiMealState {}

class ApiMealLoading extends ApiMealState {}

class ApiMealLoaded extends ApiMealState {
  final List<ApiMealsModel> meals;
  ApiMealLoaded(this.meals);
}


class ApiMealError extends ApiMealState {
  final String message;
  ApiMealError(this.message);
}