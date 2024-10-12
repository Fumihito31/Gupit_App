import 'package:flutter/material.dart';

class BotNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  BotNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      backgroundColor: Colors.black, // Set background color to black
      selectedItemColor: Colors.yellow, // Set selected item color to yellow
      unselectedItemColor: Colors.grey, // Set unselected item color to grey for better contrast
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Booking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
