import 'package:flutter/material.dart';
import '../components/background.dart'; // Import the background file
import '../components/bot_nav.dart'; // Import the custom Bottom Navigation Bar
import '../create_account/login_page.dart'; // Import the LoginPage
import 'barberAppointment.dart'; // Import the BarberAppointment page

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 4; // Index for the Profile page in the Bottom Navigation Bar

  // Handle the onTap functionality for the Bottom Navigation Bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to show confirmation dialog for logging out
  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                // Navigate to LoginPage when "Yes" is pressed
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( // Use Container for a white background
        color: Colors.white, // Set background color to white
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile picture
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('lib/assets/gelo.jpg'), // Replace with the user's profile image
                ),
              ),
              SizedBox(height: 20),

              // User details
              Center(
                child: Text(
                  'Gelo Paragas', // User name
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black), // Set text color to black
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  'gelo@gmail.com', // User email
                  style: TextStyle(color: Colors.grey[800]), // Use a darker grey for visibility
                ),
              ),
              SizedBox(height: 20),

              Divider(color: Colors.black), // Black divider to match the light background

              // Profile fields
              buildProfileField('Username', 'Gelo Paragas'),
              buildProfileField('Phone', '+123 456 789'),
              buildProfileField('Location', 'Calamba, Philippines'),

              Divider(color: Colors.black), // Black divider

              // Schedule button to navigate to barberAppointment.dart
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the BarberAppointment page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BarberAppointmentPage(appointments: [],)),
                    );
                  },
                  child: Text('Schedule'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.amber, // Set text color
                  ),
                ),
              ),

              SizedBox(height: 20), // Add space before the logout button

              // Logout button
              Center(
                child: ElevatedButton(
                  onPressed: _confirmLogout, // Call the confirm logout function
                  child: Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red, // Set text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Add the custom bottom navigation bar
      bottomNavigationBar: BotNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.black)), // Set label text color to black
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)), // Set value text color to black
        ],
      ),
    );
  }
}
