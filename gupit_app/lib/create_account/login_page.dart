import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Add background color
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/assets/CASUAL.png', height: 100),
                SizedBox(height: 20),
                CustomTextField(labelText: "Email"),
                SizedBox(height: 20),
                CustomTextField(labelText: "Password", isPassword: true),
                SizedBox(height: 20),
                CustomButton(
                  label: 'LOGIN',
                  onPressed: () {
                    // Navigate to the homepage after login
                    Navigator.pushReplacementNamed(context, '/homepage');
                  },
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Don’t have an account? Sign up',
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
