abstract class UpdateMealState {}

class UpdateMealInitialState extends UpdateMealState {}

class UpdateMealLoadingState extends UpdateMealState {}

class UpdateMealSuccessState extends UpdateMealState {
  final String message;
  UpdateMealSuccessState(this.message);
}

class UpdateMealErrorState extends UpdateMealState {
  final String error;
  UpdateMealErrorState(this.error);
}