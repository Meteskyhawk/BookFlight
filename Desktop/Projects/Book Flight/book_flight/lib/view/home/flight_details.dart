import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import '../../core/base/model/flight_model.dart';

class FlightDetails extends StatelessWidget {
  const FlightDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final flight = ModalRoute.of(context)!.settings.arguments as Flight;
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${flight.price}',
                  style: const TextStyle(
                    color: Color(0xFF191919),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatter.format(
                      flight.departureTime), // Format the DateTime object
                  style: const TextStyle(
                    color: Color(0xFF191919),
                    fontSize: 16,
                  ),
                ),
                const Icon(
                  Icons.flight_takeoff,
                  color: Color(0xFFEC441E),
                ),
                Text(
                  formatter
                      .format(flight.arrivalTime), // Format the DateTime object
                  style: const TextStyle(
                    color: Color(0xFF191919),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
  }
}
