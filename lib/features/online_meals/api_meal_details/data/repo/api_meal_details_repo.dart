import 'package:meal_mate/core/networking/api_endpoints.dart';
import 'package:meal_mate/core/networking/dio_helper.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/data/model/api_meal_details_model.dart';

  class ApiMealDetailRepo {
    Future<ApiMealDetailModel> fetchMealDetail(String id) async {
      final response = await DioHelper().getRequest(
        ApiEndpoints.lookupById,
        query: {"i": id},
      );

      final List meals = response.data["meals"];
      return ApiMealDetailModel.fromJson(meals.first);
    }
  }
