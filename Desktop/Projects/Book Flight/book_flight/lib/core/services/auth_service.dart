import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Hardcoded values for testing
  final String clientId = '7LWnS5jskPAJEMGGFvbnplsBiMkcnOEd';
  final String clientSecret = 'C7NcpOkPY3qkWEmI';

  Future<String> getAccessToken() async {
    try {
      print('Attempting to get access token with:');
      print('Client ID: $clientId');
      print('Client Secret: $clientSecret');

      final response = await http.post(
        Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'client_credentials',
          'client_id': clientId,
          'client_secret': clientSecret,
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['access_token'];
      } else {
        throw Exception(
            'Failed to obtain access token: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (e) {
      print('Error in getAccessToken: $e');
      rethrow;
    }
  }

  // Function to fetch airport suggestions from Amadeus API
  Future<List<String>> fetchAirportSuggestions(
      String query, String accessToken) async {
    // Make the GET request to the airport suggestions API
    final response = await http.get(
      Uri.parse(
          'https://test.api.amadeus.com/v1/reference-data/locations?subType=AIRPORT&keyword=$query&page[limit]=10'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> airports = data['data'];

      // Map the response to a list of strings (airport name and city)
      return airports.map((airport) {
        return '${airport['name']} (${airport['iataCode']}) - ${airport['address']['cityName']}';
      }).toList();
    } else {
      throw Exception(
          'Failed to load airport suggestions: ${response.statusCode}');
    }
  }
}
