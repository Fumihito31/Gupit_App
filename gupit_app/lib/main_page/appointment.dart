import 'package:flutter/material.dart';
import '../components/bot_nav.dart'; // Import your custom Bottom Navigation Bar

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  int _selectedTab = 0; // Toggle index for the Upcoming, Completed, and Canceled tabs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Ensure a consistent background color
      bottomNavigationBar: BotNavBar(
        selectedIndex: 1, // Index for Appointment page
        onTap: (index) {
          // Handle bottom nav bar item taps here
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
              child: Text(
                'Appointment',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            _buildToggleTabs(), // Tab toggle buttons
            SizedBox(height: 10),
            Expanded(
              child: _buildAppointmentList(), // Display the list of appointments
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabButton('Upcoming', 0),
          _buildTabButton('Completed', 1),
          _buildTabButton('Cancelled', 2),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentList() {
    // Sample data for appointments
    List<Map<String, String>> appointments = [
      {
        'status': 'Pending',
        'shopName': 'Oscar Barbershop',
        'address': '2884 Kenwood Place, Fort Lauderdale, Florida, 33301',
        'date': '01 August 2020 - 15:30 pm',
        'price': '\$42',
        'image': 'lib/assets/BS2.jpg', // Replace with your image path
      },
      {
        'status': 'Pending',
        'shopName': 'Old Town Barbershop',
        'address': '1919 Walt Nuzum Farm Road, PRIDDY, Texas, 76870',
        'date': '31 July 2020 - 13:30 pm',
        'price': '\$32',
        'image': 'lib/assets/BS1.jpg', // Replace with your image path
      },
    ];

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return _buildAppointmentCard(appointments[index]);
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, String> appointment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 32, // Ensure it fits within the screen
        ),
        child: Card(
          color: Color(0xff2b2b2b), // Dark card background
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        appointment['image']!,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment['shopName']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            appointment['address']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            appointment['date']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: ${appointment['price']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle Cancel Appointment
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Make the background transparent
                        side: BorderSide(color: Colors.white), // White border
                      ),
                      child: Text(
                        'Cancel Appointment',
                        style: TextStyle(
                          color: Colors.white, // Change text color to white
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
