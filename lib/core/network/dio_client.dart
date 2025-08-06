import 'package:dio/dio.dart';

class DioClient {
  final Dio instance = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.18:3000/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  DioClient() {
    instance.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}
