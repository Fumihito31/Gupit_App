import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(221, 0, 0, 0), // Set the background color to black
      child: child,
    );
  }
}
