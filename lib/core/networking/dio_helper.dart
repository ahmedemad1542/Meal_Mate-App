import 'package:dio/dio.dart';
import 'package:meal_mate/core/networking/api_endpoints.dart';

class DioHelper {
  DioHelper._internal();
  static final DioHelper _dioHelper = DioHelper._internal();
  factory DioHelper() => _dioHelper;

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.getAllUsers
    )
  );
  //GET
  get({required String endpoint, required})
}
