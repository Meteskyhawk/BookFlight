import 'package:book_flight/view/home/flight_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/base/model/flight_model.dart';

class SearchResultsPageV2 extends StatelessWidget {
  final List<Flight> flights;

  const SearchResultsPageV2({Key? key, required this.flights})
      : super(key: key);

  // Add this method to generate dummy flights
  static List<Flight> generateDummyFlights() {
    return [
      Flight(
        airline: 'London',
        flightNumber: 'LHR 230',
        departureTime: DateTime(2023, 5, 1, 5, 50),
        arrivalTime: DateTime(2023, 5, 1, 7, 30),
        from: 'LHR',
        to: 'AMS',
        departureAirport: 'Stansted',
        arrivalAirport: 'Amsterdam',
        price: 230,
        id: '1907',
      ),
      Flight(
        airline: 'THY',
        flightNumber: 'AMS 420',
        departureTime: DateTime(2023, 5, 1, 4, 30),
        arrivalTime: DateTime(2023, 5, 1, 6, 30),
        from: 'AMS',
        to: 'LHR',
        departureAirport: 'Amsterdam',
        arrivalAirport: 'Stansted',
        price: 360,
        id: '1907',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Use the dummy flights if the provided list is empty
    final displayFlights = flights.isEmpty ? generateDummyFlights() : flights;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Search Result',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: displayFlights.length,
        itemBuilder: (context, index) {
          final flight = displayFlights[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        flight.airline,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      Text(
                        flight.flightNumber,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    // ignore: unnecessary_string_interpolations
                    '${_formatDuration(flight.departureTime, flight.arrivalTime)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimeAndLocation(
                        time: DateFormat('H.mm').format(flight.departureTime),
                        location: '${flight.from} (${flight.departureAirport})',
                      ),
                      const Icon(Icons.flight_takeoff, color: Colors.orange),
                      _buildTimeAndLocation(
                        time: DateFormat('H.mm').format(flight.arrivalTime),
                        location: '${flight.to} (${flight.arrivalAirport})',
                        alignment: CrossAxisAlignment.end,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.airline_seat_recline_normal, size: 20),
                          SizedBox(width: 4),
                          Text('Business Class'),
                        ],
                      ),
                      Text(
                        'From \$${flight.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FlightConfirmation(flight: flight),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEC441E),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Check'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeAndLocation({
    required String time,
    required String location,
    CrossAxisAlignment alignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          time,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          location,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  String _formatDuration(DateTime departure, DateTime arrival) {
    final duration = arrival.difference(departure);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours.toString().padLeft(2, '0')} hr ${minutes.toString().padLeft(2, '0')}min';
  }
}
