import 'package:flutter/material.dart';

import 'payment.dart';

class ChooseSeat extends StatefulWidget {
  const ChooseSeat({super.key});

  @override
  State<ChooseSeat> createState() => _ChooseSeatState();
}

class _ChooseSeatState extends State<ChooseSeat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Seat', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
        child: Column(
          children: [
            _buildLegend(),
            const SizedBox(height: 8),
            Expanded(child: _buildPlaneWithSeats()),
            const SizedBox(height: 8), // Reduced from 16
            _buildConfirmButton(context),
            const SizedBox(height: 60), // Increased from 16
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(Colors.orange, 'Selected'),
        const SizedBox(width: 16),
        _legendItem(Colors.grey.shade600, 'Emergency exit'),
        const SizedBox(width: 16),
        _legendItem(Colors.grey.shade300, 'Reserved'),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildPlaneWithSeats() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            CustomPaint(
              painter: PlanePainter(),
              size: Size(constraints.maxWidth, constraints.maxHeight),
            ),
            Positioned(
              top: constraints.maxHeight * 0.1, // Reduced from 0.15
              left: constraints.maxWidth * 0.1,
              right: constraints.maxWidth * 0.1,
              bottom: 0,
              child: _buildSeatGrid(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSeatGrid() {
    final seatLayout = [
      ['', '', '', '', ''], // Empty row for space at the front
      ['1A', '1B', '', '1C', '1D'],
      ['2A', '2B', '', '2C', '2D'],
      ['3A', '3B', '', '3C', '3D'],
      ['4A', '4B', '', '4C', '4D'],
      ['5A', '1B', '', '5C', '5D'],
      ['6A', '6B', '', '6C', '6D'],
      ['1A', '1B', '', '1C', '1D'],
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1.1, // Reduced from 1.3 to make seats larger
        crossAxisSpacing: 8,
        mainAxisSpacing: 8, // Increased from 4 to add more vertical space
      ),
      itemCount: seatLayout.length * seatLayout[0].length,
      itemBuilder: (context, index) {
        final row = index ~/ 5;
        final col = index % 5;
        final seat = seatLayout[row][col];

        if (seat.isEmpty) return const SizedBox.shrink();

        Color seatColor = Colors.white;
        if (seat == '2B') {
          seatColor = Colors.orange;
        } else if (seat.startsWith('5') || seat == '1B' && row == 5) {
          seatColor = Colors.grey.shade600;
        } else if (seat == '2C' || seat.startsWith('6')) {
          seatColor = Colors.grey.shade300;
        }

        return Container(
          decoration: BoxDecoration(
            color: seatColor,
            borderRadius: BorderRadius.circular(6), // Increased from 4
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Text(
              seat,
              style: TextStyle(
                color: seatColor == Colors.white ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14, // Increased from 12
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Payment()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEC441E),
          padding:
              const EdgeInsets.symmetric(vertical: 16), // Increased padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Confirm',
            style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}

class PlanePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start from the bottom-left corner
    path.moveTo(size.width * 0.05, size.height * 0.95);

    // Left side of the plane
    path.lineTo(size.width * 0.05, size.height * 0.2);

    // Front of the plane (curved)
    path.quadraticBezierTo(
      size.width * 0.2, size.height * 0.05, // Control point
      size.width * 0.5, size.height * 0.05, // End point
    );
    path.quadraticBezierTo(
      size.width * 0.8, size.height * 0.05, // Control point
      size.width * 0.95, size.height * 0.2, // End point
    );

    // Right side of the plane
    path.lineTo(size.width * 0.95, size.height * 0.95);

    // Bottom of the plane (slightly curved)
    path.quadraticBezierTo(
      size.width * 0.5, size.height, // Control point
      size.width * 0.05, size.height * 0.95, // End point
    );

    // Close the path
    path.close();

    // Draw the plane body
    canvas.drawPath(path, paint);

    // Draw wings
    final wingPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final wingPath = Path();

    // Left wing
    wingPath.moveTo(size.width * 0.05, size.height * 0.6);
    wingPath.lineTo(0, size.height * 0.7);
    wingPath.lineTo(size.width * 0.05, size.height * 0.8);

    // Right wing
    wingPath.moveTo(size.width * 0.95, size.height * 0.6);
    wingPath.lineTo(size.width, size.height * 0.7);
    wingPath.lineTo(size.width * 0.95, size.height * 0.8);

    // Draw the wings
    canvas.drawPath(wingPath, wingPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
