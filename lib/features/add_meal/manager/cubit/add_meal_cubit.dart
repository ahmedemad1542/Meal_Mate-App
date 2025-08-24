import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/features/add_meal/data/repo/add_meal_repo.dart';
import 'package:meal_mate/features/add_meal/manager/cubit/add_meal_states.dart';

class AddMealCubit extends Cubit<AddMealStates> {
  final AddMealRepo addMealRepo;

  AddMealCubit(this.addMealRepo) : super(AddMealInitialState());

  void loadMeals() {
    emit(AddMealLoadingState());
    try {
      final meals = addMealRepo.getMeals();
      emit(AddMealSuccessState(meals));
    } catch (e) {
      emit(AddMealErrorState(e.toString()));
    }
  }


  Future<void> addMeal(MealModel meal) async {
    emit(AddMealLoadingState());
    try {
      await addMealRepo.addMeal(meal);
      final meals = addMealRepo.getMeals();
      emit(AddMealSuccessState(meals));
    } catch (e) {
      emit(AddMealErrorState(e.toString()));
    }
  }
}
