import 'package:flutter/material.dart';
import '../main_page/homepage.dart'; // Import HomePage
import '../main_page/chat.dart'; // Import ChatPage
import '../main_page/profile.dart'; // Import ProfilePage
import '../main_page/appointment.dart'; // Import AppointmentPage
import '../main_page/shop.dart'; // Import ShopPage

class BotNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  BotNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 238, 178, 0),
      unselectedItemColor: const Color(0xff757575),
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        onTap(index);
        _handleNavigation(index, context); // Call the navigation function
      },
      backgroundColor: const Color.fromARGB(255, 56, 56, 58),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          activeIcon: Icon(Icons.calendar_today),
          label: 'Appointment',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          activeIcon: Icon(Icons.chat_bubble),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined), // Added icon for shop
          activeIcon: Icon(Icons.shopping_bag), // Active icon for shop
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  void _handleNavigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AppointmentPage()), // Navigate to AppointmentPage
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ShopPage()), // Navigate to ShopPage
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
      default:
        // Handle other tabs if necessary
        break;
    }
  }
}
