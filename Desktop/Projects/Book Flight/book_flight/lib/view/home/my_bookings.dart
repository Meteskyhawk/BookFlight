import 'package:flutter/material.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            BookingCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFEC441E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Indigo',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeLocation('5.50', 'LHR', 'London Stansted Airport'),
                const Icon(Icons.flight_takeoff, color: Colors.orange),
                _buildTimeLocation('7.30', 'AMS', 'Amsterdam Schipol\nAirport'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem('Date', '15/07/2022', Icons.calendar_today),
                _buildInfoItem('Time', '09.30', Icons.access_time),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem('Flight', 'IN 230', Icons.flight),
                _buildInfoItem('Gate', '22', Icons.door_front_door),
                _buildInfoItem('Seat', '2B', Icons.event_seat),
                _buildInfoItem(
                    'Class', 'Economy', Icons.airline_seat_recline_extra),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEC441E),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Modify',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeLocation(String time, String code, String airport) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(time,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(code,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(airport, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildInfoItem(String title, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.black54),
            const SizedBox(width: 4),
            Text(value,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
