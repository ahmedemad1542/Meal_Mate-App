import 'package:meal_mate/features/online_meals/api_meal_details/data/model/api_meal_details_model.dart';

abstract class ApiMealDetailState {}

class ApiMealDetailInitial extends ApiMealDetailState {}

class ApiMealDetailLoading extends ApiMealDetailState {}

class ApiMealDetailLoaded extends ApiMealDetailState {
  final ApiMealDetailModel mealDetail;
  ApiMealDetailLoaded(this.mealDetail);
}

class ApiMealDetailError extends ApiMealDetailState {
  final String message;
  ApiMealDetailError(this.message);
}
