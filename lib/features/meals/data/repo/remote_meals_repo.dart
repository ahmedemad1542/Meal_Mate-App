import 'package:dartz/dartz.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/networking/dio_helper.dart';

class RemoteMealsRepo {
  final DioHelper _dio = DioHelper();

  // get meals online
  Future<Either<String, List<MealModel>>> getMeals() async {
    try {
      final response = await _dio.getRequest('/meals');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final meals = data.map((meal) => MealModel.fromMap(meal)).toList();
        return Right(meals);
      } else {
        return Left('Failed to load meals: ${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}