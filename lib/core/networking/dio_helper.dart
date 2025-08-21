import 'package:dio/dio.dart';
import 'package:meal_mate/core/networking/api_endpoints.dart';
import 'package:meal_mate/core/storage/cache_data.dart';

class DioHelper {
  DioHelper._internal();
  static final DioHelper _dioHelper = DioHelper._internal();
  factory DioHelper() => _dioHelper;

  Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.getAllUsers,
      connectTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 15),
    ),
  );

  //GET
  Future<Response<dynamic>> getRequest(
    String endpoint, {
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    final response = await dio.get(
      endpoint,
      data: isFormData ? FormData.fromMap(data ?? {}) : data,
      options: Options(
        headers: {
         if (isAuthorized) "Autorization": "Bearer ${CacheData.accessToken} "},
      ),
    );
    return response;
  }
}
