import 'package:flutter/material.dart';
import 'create_account/login_page.dart';
import 'create_account/register_page.dart';
import 'main_page/homepage.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
    '/': (context) => LoginPage(),
    '/register': (context) => RegisterPage(),
    '/homepage': (context) => HomePage(), // Make sure you have a HomePage widget
  },
    );
  }
}
