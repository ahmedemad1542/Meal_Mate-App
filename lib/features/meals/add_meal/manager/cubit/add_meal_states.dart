import 'package:meal_mate/core/model/meal_model.dart';

abstract class AddMealState {}

class AddMealInitialState extends AddMealState {}

class AddMealLoadingState extends AddMealState {}

class AddMealSuccessState extends AddMealState {
  final String message;
  AddMealSuccessState(this.message);
}

class AddMealErrorState extends AddMealState {
  final String error;
  AddMealErrorState(this.error);
}
