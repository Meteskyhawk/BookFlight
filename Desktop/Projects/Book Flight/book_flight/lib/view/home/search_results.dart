import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Make sure this is imported
import '../../core/base/model/flight_model.dart';

class SearchResultsPage extends StatelessWidget {
  final List<Flight> flights;

  const SearchResultsPage({super.key, required this.flights});

  @override
  Widget build(BuildContext context) {
    // Initialize the formatter here
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');

    if (flights.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Search Result'),
        ),
        body: const Center(
          child: Text(
            'No flights found for the given criteria',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: flights.length,
        itemBuilder: (context, index) {
          final flight = flights[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatter.format(flight.departureTime),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const Icon(Icons.flight_takeoff, color: Colors.orange),
                      Text(
                        formatter.format(flight.arrivalTime),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${flight.from} (${flight.departureAirport})',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '${flight.to} (${flight.arrivalAirport})',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
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
}
