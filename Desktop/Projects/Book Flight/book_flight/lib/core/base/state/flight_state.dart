import 'package:flutter/material.dart';
import '../model/flight_model.dart';
import '../../services/flight_service.dart';
import '../../services/auth_service.dart';

class FlightState with ChangeNotifier {
  final FlightService _flightService = FlightService();
  final AuthService _authService = AuthService();
  List<Flight> _flights = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Flight> get flights => _flights;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchFlightDetails(String from, String to, String date) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('Fetching flight details for: from=$from, to=$to, date=$date');
      final accessToken = await _authService.getAccessToken();
      print('Access token obtained: $accessToken');
      _flights =
          await _flightService.getFlightDetails(from, to, date, accessToken);
      print('Fetched flights: $_flights');
      if (_flights.isEmpty) {
        _errorMessage = 'No flights found for the given criteria';
      }
    } catch (e) {
      _errorMessage = e.toString();
      print('Error fetching flight details: $_errorMessage');
      print('Stack trace: ${StackTrace.current}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
