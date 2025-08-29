import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/data/repo/local_meals_repo.dart';
import 'package:meal_mate/features/local_meals/add_meal/manager/cubit/add_meal_states.dart';

class AddMealCubit extends Cubit<AddMealState> {
  final LocalMealsRepo localMealsRepo;

  AddMealCubit(this.localMealsRepo) : super(AddMealInitialState());

  Future<void> addMeal(MealModel meal) async {
    emit(AddMealLoadingState());
    try {
      await localMealsRepo.addMeal(meal);
      emit(AddMealSuccessState("Meal added successfully"));
    } catch (e) {
      emit(AddMealErrorState("Failed to add meal: ${e.toString()}"));
    }
  }
}