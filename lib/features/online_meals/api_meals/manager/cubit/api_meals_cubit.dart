import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/online_meals/api_meals/data/repo/api_meals_repo.dart';
import 'package:meal_mate/features/online_meals/api_meals/manager/cubit/api_meals_state.dart';


class ApiMealCubit extends Cubit<ApiMealState> {
  final ApiMealsRepo apiMealsRepo;
  ApiMealCubit(this.apiMealsRepo) : super(ApiMealInitial());

  Future<void> getMealsByCategory(String category) async {
    if (state is ApiMealLoaded) return;
    emit(ApiMealLoading());
    try {
      final data = await apiMealsRepo.fetchMealsByCategory(category);
      emit(ApiMealLoaded(data));
    } catch (e) {
      emit(ApiMealError(e.toString()));
    }
  }

  Future<void> getMealsByArea(String area) async {
    emit(ApiMealLoading());
    try {
      final data = await apiMealsRepo.fetchMealsByArea(area);
      emit(ApiMealLoaded(data));
    } catch (e) {
      emit(ApiMealError(e.toString()));
    }
  }
}
