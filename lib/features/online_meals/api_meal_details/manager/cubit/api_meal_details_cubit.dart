import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/data/repo/api_meal_details_repo.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/manager/cubit/api_meal_details_state.dart';

class ApiMealDetailCubit extends Cubit<ApiMealDetailState> {
  final ApiMealDetailRepo mealDetailRepo;
  ApiMealDetailCubit(this.mealDetailRepo) : super(ApiMealDetailInitial());

  Future<void> getMealDetail(String id) async {
    emit(ApiMealDetailLoading());
    try {
      final data = await mealDetailRepo.fetchMealDetail(id);
      emit(ApiMealDetailLoaded(data));
    } catch (e) {
      emit(ApiMealDetailError(e.toString()));
    }
  }
}
