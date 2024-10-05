import 'package:flutter/material.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              'OTP Verification',
              style: TextStyle(
                color: Color(0xFF191919),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Enter the verification code we just sent on your phone number.',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return _buildOtpInputBox(index);
              }),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/phone-login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Verify',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 50), // Reduced space between button and text
            const Center(
              child: Column(
                children: [
                  Text(
                    'Resend OTP in 23s',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Resend OTP',
                    style: TextStyle(
                      color: Color(0xFFEC441E),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpInputBox(int index) {
    return SizedBox(
      width: 64,
      height: 64,
      child: TextField(
        controller: _controllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '', // To hide the counter below TextField
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _controllers[index].text.isNotEmpty
                  ? const Color(0xFFEC441E)
                  : const Color(0xFFD0D5DD),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFEC441E),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: const Color(0xFFF3F4F6),
        ),
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF191919),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).nextFocus(); // Move to the next field
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context)
                .previousFocus(); // Move to the previous field
          }
          setState(() {}); // Refresh the border color when filled
        },
      ),
    );
  }
}
