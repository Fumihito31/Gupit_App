import 'package:flutter/material.dart';
import '../components/background.dart'; // Import the background file
import '../components/bot_nav.dart'; // Import BotNavBar

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Keep track of selected tab index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected tab index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background( // Apply black background
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image banner
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage('lib/assets/gelo.jpg'), // Replace with the banner image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                
                // Nearest Barbershop section
                Text(
                  "Nearest Barbershop",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), // White text
                ),
                SizedBox(height: 10),
                buildBarberList(), // Function to display list of nearest barbershops

                SizedBox(height: 20),

                // Most recommended section
                Text(
                  "Most Recommended",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), // White text
                ),
                SizedBox(height: 10),
                buildBarberList(), // Reusing the same list
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BotNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildBarberList() {
    // Example barber data list
    final barbers = [
      {'name': 'Oscar Barbershop', 'service': 'Haircut & Styling', 'image': 'lib/assets/1.jpg', 'distance': '2.6km'},
      {'name': 'Old Town', 'service': 'Haircut & Massage', 'image': 'lib/assets/2.jpg', 'distance': '5.0km'},
      {'name': 'Lookin Sharp Barber', 'service': 'Haircut & Styling', 'image': 'lib/assets/2.jpg', 'distance': '10.3km'},
      {'name': 'Get Buzzed Barber', 'service': 'Beard Trim', 'image': 'lib/assets/3.jpg', 'distance': '8.2km'},
    ];

    return Column(
      children: barbers.map((barber) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(barber['image']!, width: 50, height: 50, fit: BoxFit.cover),
          ), // Barber image
          title: Text(barber['name']!, style: TextStyle(color: Colors.white)), // Set text to white
          subtitle: Text('${barber['service']} - ${barber['distance']}', style: TextStyle(color: Colors.white70)), // Set text to lighter white
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent, // Button color
            ),
            onPressed: () {},
            child: Text('Book', style: TextStyle(color: Colors.black)),
          ),
        );
      }).toList(),
    );
  }
}
