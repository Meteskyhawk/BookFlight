import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/base/view/base_view.dart';
import '../../../core/base/state/base_state.dart';
import 'forgot_password.dart';
import '../../../core/base/state/auth_state.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends BaseState<EmailLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPhoneSelected = false;
  bool keepMeSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthState>(
        viewModel: context.read<AuthState>(),
        onModelReady: (model) {},
        builder: (context, model, child) => Scaffold(
                body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    color: !isPhoneSelected
                                        ? const Color(0xFFEC441E)
                                        : const Color(0xFF555555),
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
                              Navigator.pushNamed(context, '/phone-login');
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
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: const Icon(Icons.visibility_off),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
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
                                    builder: (context) =>
                                        const ForgotPassword()),
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
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, '/book-flight');
                          }
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
                        icon: const Icon(Icons.g_mobiledata,
                            color: Color(0xFFEC441E)),
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
                    ]),
              ),
            )));
  }
}
