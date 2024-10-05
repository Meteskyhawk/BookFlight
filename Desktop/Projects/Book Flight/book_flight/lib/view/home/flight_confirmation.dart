import 'package:flutter/material.dart';
import '../../core/base/model/flight_model.dart';
import 'choose_seat.dart';

class FlightConfirmation extends StatelessWidget {
  final Flight flight;

  const FlightConfirmation({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Flight details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        flight.airline,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeLocation('5.50', 'LHR'),
                        const Icon(
                          Icons.flight_takeoff,
                          color: Color(0xFFEC441E),
                        ),
                        _buildTimeLocation('7.30', 'AMS'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAirportName(flight.departureAirport),
                        _buildAirportName(flight.arrivalAirport),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDateTimeInfo(
                            'Date', '15/07/2022', Icons.calendar_today),
                        _buildDateTimeInfo('Time', '09.30', Icons.access_time),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 24, color: Colors.black),
                          children: [
                            const TextSpan(text: 'Price '),
                            TextSpan(
                              text: '\$${flight.price}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 24), // Reduce this height or remove if needed
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color.fromARGB(255, 236, 68, 30),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Cancel',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 236, 68, 30))),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ChooseSeat(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 236, 68, 30),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                'Confirm',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeLocation(String time, String location) {
    return Column(
      children: [
        Text(
          time,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          location,
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildAirportName(String name) {
    return Text(
      name,
      style: const TextStyle(fontSize: 14, color: Colors.grey),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDateTimeInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
