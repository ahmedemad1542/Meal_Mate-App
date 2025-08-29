

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/online_meals/category_feature/data/repo/category_repo.dart';
import 'package:meal_mate/features/online_meals/category_feature/manager/cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo categoryRepo;
  CategoryCubit(this.categoryRepo) : super(CategoryInitial());

  Future<void> getCategories() async {
    if (state is CategoryLoaded) return;
    emit(CategoryLoading());
    try {
      final data = await categoryRepo.fetchCategories();
      emit(CategoryLoaded(data));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}