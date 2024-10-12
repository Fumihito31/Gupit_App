import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  CustomButton({required this.label, this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon != null ? Icon(icon) : Container(), // Show icon if provided
      label: Text(label),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50), // Make button stretch across screen
      ),
    );
  }
}
