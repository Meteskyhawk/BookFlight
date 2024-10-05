import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0, // No shadow for the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40), // Spacing from the AppBar to title
              const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Color(0xFF191919),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14), // Adjusted spacing
              const Text(
                'Enter your email address to get the password reset link.',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 32), // Spacing before email field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'hello@example.com', // Placeholder text
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 32), // Spacing between input and button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reset-password');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  minimumSize: const Size(double.infinity, 48), // Button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Password Reset',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 300), // Spacing before "Create an account"
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    'Create an account',
                    style: TextStyle(
                      color: Color(0xFFEC441E),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
}
