import 'package:flutter/foundation.dart';
import 'package:book_flight/core/base/model/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl =
      'test.api.amadeus.com'; // Replace with your actual API URL

  // Add this login method
  Future<User?> login(String email, String password) async {
    final url =
        Uri.parse('$_baseUrl/login'); // Replace with your login endpoint
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }
  }

  void logout() {
    // Handle any cleanup or token invalidation here if necessary
  }
}

class AuthState extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.login(email, password);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void logout() {
    _authService.logout();
    _user = null;
    notifyListeners();
  }
}
