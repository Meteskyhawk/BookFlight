import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor; // Add this line
  final double? width; // Add this line
  final double? height; // Add this line
  final Icon? icon; // Add this line

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor, // Add this line
    this.width, // Add this line
    this.height, // Add this line
    this.icon, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Add this line
      height: height, // Add this line
      child: ElevatedButton.icon(
        // Change to ElevatedButton.icon
        icon: icon ?? Container(), // Add this line
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
