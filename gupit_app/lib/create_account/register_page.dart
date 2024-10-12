import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Background color
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/assets/CASUAL.png', height: 100), // Temporary logo
                SizedBox(height: 20),
                CustomTextField(labelText: "Email"),
                SizedBox(height: 20),
                CustomTextField(labelText: "Password", isPassword: true),
                SizedBox(height: 20),
                CustomTextField(labelText: "Phone Number"),
                SizedBox(height: 20),
                CustomButton(
                  label: 'REGISTER',
                  onPressed: () {
                    // Navigate to the homepage after registration
                    Navigator.pushReplacementNamed(context, '/homepage');
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to Login Page
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
