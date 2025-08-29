import 'package:meal_mate/core/networking/api_endpoints.dart';
import 'package:meal_mate/core/networking/dio_helper.dart';
import 'package:meal_mate/features/online_meals/area_feature/data/model/area_model.dart';

class AreaRepo {
  List<AreaModel> _cachedAreas = [];

  Future<List<AreaModel>> fetchAreas() async {
    if (_cachedAreas.isNotEmpty) return _cachedAreas;

    final response = await DioHelper().getRequest(ApiEndpoints.listAreas);

    final List list = response.data["meals"];
    _cachedAreas = list.map((e) => AreaModel.fromJson(e)).toList();
    return _cachedAreas;
  }
}