import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'forgot_password.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  bool isPhoneSelected = true;
  String phoneNumber = '';
  bool keepMeSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(24.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 100),
              const Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFF191919),
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Welcome back to the app',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPhoneSelected = false;
                      });
                      Navigator.pushNamed(context, '/email-login');
                    },
                    child: Column(
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                            color: isPhoneSelected
                                ? const Color(0xFF555555)
                                : const Color(0xFFEC441E),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (!isPhoneSelected)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            height: 2,
                            width: 20,
                            color: const Color(0xFFEC441E),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPhoneSelected = true;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'Phone Number',
                          style: TextStyle(
                            color: isPhoneSelected
                                ? const Color(0xFFEC441E)
                                : const Color(0xFF555555),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (isPhoneSelected)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            height: 2,
                            width: 20,
                            color: const Color(0xFFEC441E),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              IntlPhoneField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                initialCountryCode: 'US',
                onChanged: (phone) {
                  setState(() {
                    phoneNumber = phone.completeNumber;
                  });
                },
              ),
              const SizedBox(height: 8), // Reduced from 16 to 8

              const SizedBox(height: 4), // Reduced from 8 to 4
              TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: keepMeSignedIn,
                        onChanged: (value) {
                          setState(() {
                            keepMeSignedIn = value!;
                          });
                        },
                        activeColor: const Color(0xFFEC441E),
                      ),
                      const Text(
                        'Keep me signed in',
                        style: TextStyle(
                          color: Color(0xFF191919),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFFEC441E),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // You might want to add validation here if needed
                  Navigator.pushNamed(context, '/verify-otp');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEC441E),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(child: Text('or sign in with')),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.g_mobiledata, color: Color(0xFFEC441E)),
                label: const Text('Continue with Google',
                    style: TextStyle(color: Color(0xFFEC441E))),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE4E6EA),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFFEC441E)),
                  ),
                ),
              ),
              const SizedBox(height: 62),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    'Create an account',
                    style: TextStyle(
                      color: Color(0xFFEC441E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ])));
  }
}
