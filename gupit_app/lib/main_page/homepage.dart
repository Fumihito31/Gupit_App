import 'package:flutter/material.dart';
import '../components/bot_nav.dart';
import '../main_page/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the currently selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the respective page
    if (index == 3) {
      // Navigate to the ProfilePage when the Profile tab is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } else {
      // Handle other tabs (you can implement this logic as needed)
      // For example, you can show other pages or content here
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              buildBarberList(), // Function to display list of nearest barbershops

              SizedBox(height: 20),

              // Most recommended section
              Text(
                "Most Recommended",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              buildBarberList(), // Reusing the same list

              SizedBox(height: 20),

              // Find a barber nearby section
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
                child: Center(
                  child: Text("Find a Barber Nearby"),
                ),
              ),
            ],
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
      {'name': 'Alma Barbershop', 'service': 'Haircut & Styling', 'image': 'lib/assets/gelo2.jpg', 'distance': '2.6km'},
      {'name': 'Herc Barbershop', 'service': 'Haircut & Massage', 'image': 'lib/assets/gelo.jpg', 'distance': '5.0km'},
      {'name': 'Bartman', 'service': 'Haircut & Styling', 'image': 'lib/assets/gelo.jpg', 'distance': '10.3km'},
    ];

    return Column(
      children: barbers.map((barber) {
        return ListTile(
          leading: Image.asset(barber['image']!, width: 50, height: 50), // Barber image
          title: Text(barber['name']!),
          subtitle: Text('${barber['service']} - ${barber['distance']}'),
          trailing: ElevatedButton(
            onPressed: () {},
            child: Text('Booking'),
          ),
        );
      }).toList(),
    );
  }
}
