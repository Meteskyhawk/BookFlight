import 'package:book_flight/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class NetworkManager {
  static final Dio _dio = Dio();

  static Dio get dio => _dio;

  static void init() {
    _dio.options.baseUrl = 'https://api.aviationstack.com/v1';
    _dio.options.connectTimeout = const Duration(milliseconds: 5000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 3000);
  }
}

// In your main.dart or wherever your app initializes
void main() {
  NetworkManager.init(); // Ensure this is called before any network requests
  runApp(const MyApp());
}

// Example usage in a service or repository
class ApiService {
  Future<Response> fetchData() async {
    return await NetworkManager.dio.get('/endpoint');
  }
}
