import 'package:meal_mate/core/networking/api_endpoints.dart';
import 'package:meal_mate/core/networking/dio_helper.dart';
import 'package:meal_mate/features/online_meals/category_feature/data/model/category_model.dart';

class CategoryRepo {
  List<CategoryModel> _cachedCategories = [];

  Future<List<CategoryModel>> fetchCategories() async {
    if (_cachedCategories.isNotEmpty) return _cachedCategories;

    final response = await DioHelper().getRequest(ApiEndpoints.listCategories);

    final List list = response.data["categories"];
    _cachedCategories = list.map((e) => CategoryModel.fromJson(e)).toList();
    return _cachedCategories;
  }
}