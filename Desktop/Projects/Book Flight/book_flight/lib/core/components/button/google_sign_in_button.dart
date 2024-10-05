import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Google,
      onPressed: onPressed,
    );
  }
}
