import 'package:flutter/material.dart';
import 'package:book_flight/view/home/boarding_pass.dart'; // Add this import

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Indigo',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16),
                      SizedBox(width: 4),
                      Text('15/07/2022'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('5.50',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('LHR', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Icon(Icons.flight_takeoff, color: Colors.orange, size: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('7.30',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('AMS', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: TextStyle(fontSize: 18)),
                  Text('\$230',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEC441E),
                      )),
                ],
              ),
              const SizedBox(height: 24),
              _buildTextField('Card number', '5300 0000 0000 0000'),
              const SizedBox(height: 16),
              _buildTextField('Card holder name', 'John Doe'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField('CVV', '000')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField('Expiry date', '05/24')),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.credit_card, size: 30, color: Colors.grey[600]),
                  Icon(Icons.credit_card, size: 30, color: Colors.grey[600]),
                  Icon(Icons.credit_card, size: 30, color: Colors.grey[600]),
                  Icon(Icons.payment, size: 30, color: Colors.grey[600]),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BoardingPass(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEC441E),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Confirm',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  side: const BorderSide(
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Cancel',
                    style: TextStyle(color: Color(0xFFEC441E), fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: value,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
      ),
    );
  }
}
