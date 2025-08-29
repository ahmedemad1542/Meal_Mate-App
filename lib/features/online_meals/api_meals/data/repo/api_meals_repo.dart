import 'package:meal_mate/core/networking/api_endpoints.dart';
import 'package:meal_mate/core/networking/dio_helper.dart';
import 'package:meal_mate/features/online_meals/api_meals/data/model/api_meals_repo.dart';

class ApiMealsRepo {
  List<ApiMealsModel> _cachedMeals = [];

  Future<List<ApiMealsModel>> fetchMealsByCategory(String category) async {
    if (_cachedMeals.isNotEmpty) return _cachedMeals;

    final response = await DioHelper().getRequest(
      ApiEndpoints.filterByCategory,
      query: {"c": category},
    );

    final List list = response.data["meals"];
    _cachedMeals = list.map((e) => ApiMealsModel.fromJson(e)).toList();
    return _cachedMeals;
  }

  Future<List<ApiMealsModel>> fetchMealsByArea(String area) async {
    final response = await DioHelper().getRequest(
      ApiEndpoints.filterByArea,
      query: {"a": area},
    );

    final List list = response.data["meals"];
    return list.map((e) => ApiMealsModel.fromJson(e)).toList();
  }
}