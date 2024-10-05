import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../base/model/flight_model.dart';

class FlightService {
  Future<List<Flight>> getFlightDetails(
      String from, String to, String date, String accessToken) async {
    final parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    final url = Uri.parse(
        'https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=$from&destinationLocationCode=$to&departureDate=${DateFormat('yyyy-MM-dd').format(parsedDate)}');

    print("Requesting flights from: $url");
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Flight data received: $data");
      return (data['data'] as List)
          .map((flight) => Flight.fromJson(flight))
          .toList();
    } else {
      print(
          'Failed to load flight details. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load flight details');
    }
  }
}
