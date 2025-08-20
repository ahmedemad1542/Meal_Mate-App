import 'package:dio/dio.dart';
import 'package:meal_mate/core/networking/api_endpoints.dart';

class DioHelper {
  DioHelper._internal();
  static final DioHelper _dioHelper = DioHelper._internal();
  factory DioHelper() => _dioHelper;

  final Dio dio = Dio(BaseOptions(baseUrl: ApiEndpoints.getAllUsers));
  //GET
  Future<Response<dynamic>> getRequest(
    String endpoint, {
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    final response = await dio.get(
      endpoint,
      queryParameters: query,
      options: options,
    );
    return  response;
  }
}
