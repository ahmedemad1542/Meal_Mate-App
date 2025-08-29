import 'package:dio/dio.dart';
import 'api_endpoints.dart';

class DioHelper {
  DioHelper._internal();
  static final DioHelper _dioHelper = DioHelper._internal();
  factory DioHelper() => _dioHelper;

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<Response> getRequest(
    String endpoint, {
    Map<String, dynamic>? query,
  }) async {
    final response = await dio.get(endpoint, queryParameters: query);
    return response;
  }
}
