import 'package:dio/dio.dart';

abstract class ApiService {
  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  });
}
