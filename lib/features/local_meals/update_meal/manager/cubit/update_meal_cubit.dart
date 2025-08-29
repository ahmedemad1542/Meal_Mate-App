import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/data/repo/local_meals_repo.dart';
import 'package:meal_mate/features/local_meals/update_meal/manager/cubit/update_meal_states.dart';

class UpdateMealCubit extends Cubit<UpdateMealState> {
  final LocalMealsRepo localMealsRepo;

  UpdateMealCubit(this.localMealsRepo) : super(UpdateMealInitialState());

  Future<void> updateMealByKey(int mealKey, MealModel updatedMeal) async {
    emit(UpdateMealLoadingState());
    try {
      final startTime = DateTime.now();

      
      await localMealsRepo.updateMealByKey(mealKey, updatedMeal);

      
      final elapsed = DateTime.now().difference(startTime);

      
      if (elapsed < const Duration(seconds: 2)) {
        await Future.delayed(const Duration(seconds: 2));
      }

      emit(UpdateMealSuccessState("Meal updated successfully"));
    } catch (e) {
      emit(UpdateMealErrorState("Failed to update meal: ${e.toString()}"));
    }
  }
}
