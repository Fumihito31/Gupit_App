import 'package:flutter/material.dart';
import '../create_account/LoginPage.dart'; // Import the login page

void main() {
  runApp(GupitApp());
}

class GupitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // Set your custom page here
    );
  }
}
