import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87, // Set the background color to black
      child: child,
    );
  }
}
