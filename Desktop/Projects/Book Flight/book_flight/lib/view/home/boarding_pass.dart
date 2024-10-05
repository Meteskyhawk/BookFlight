import 'package:flutter/material.dart';
import 'my_bookings.dart'; // Add this import

class BoardingPass extends StatelessWidget {
  const BoardingPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Boarding Pass',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Passenger info
              Row(
                children: [
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mr. John Doe',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Passenger',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset('lib/assets/indigo_logo.png',
                      height: 30), // Update with actual asset path
                ],
              ),
              const SizedBox(height: 24),
              // Flight info with icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimeLocation('5.50', 'LHR'),
                  Column(
                    children: [
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey[300],
                      ),
                      const Icon(Icons.flight_takeoff,
                          color: Color(0xFFEC441E), size: 32),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  _buildTimeLocation('7.30', 'AMS'),
                ],
              ),
              const SizedBox(height: 8),
              // Airport names
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      ' London Stansted Airport',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Amsterdam Airport Schiphol',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Date and time information
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoItem('Date', '30/09/2024', Icons.calendar_today),
                  _buildInfoItem('Time', '05.50', Icons.access_time),
                ],
              ),
              const SizedBox(height: 24),
              // Flight details: Flight, Gate, Seat, Class
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFlightDetail('Flight', 'IN 230'),
                  _buildFlightDetail('Gate', '22'),
                  _buildFlightDetail('Seat', '2B'),
                  _buildFlightDetail('Class', 'Economy'),
                ],
              ),
              const SizedBox(height: 24),
              // Barcode section
              Column(
                children: [
                  SizedBox(
                    height: 130,
                    width: 360,
                    child: Image.asset('lib/assets/barcode.png',
                        fit: BoxFit.cover), // Update with actual asset path
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'IND222B589659',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Download and book another flight buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyBookings()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEC441E),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Download',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Book another flight',
                    style: TextStyle(
                      color: Color(0xFFEC441E),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeLocation(String time, String location) {
    return Column(
      children: [
        Text(time,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(location, style: const TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget _buildInfoItem(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlightDetail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
