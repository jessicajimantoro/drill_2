import 'package:dio/dio.dart';
import 'package:drill_2/src/services/api_service.dart';

class ApiServiceImpl implements ApiService {
  final Dio httpClient;

  ApiServiceImpl({
    required this.httpClient,
  });

  @override
  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await httpClient.get(
      path,
      queryParameters: queryParameters,
    );
  }
}
