import 'package:dio/dio.dart';

Dio? dio() {
  Dio dio = Dio();
  dio.options.baseUrl = "http://192.168.100.188/api";
  dio.options.headers['accept'] = "Application/Json";
  dio.options.headers['Allow'] = 'GET, POST, PUT';
  return dio;
}
