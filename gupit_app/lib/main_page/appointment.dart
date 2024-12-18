import 'package:flutter/material.dart';
import '../components/bot_nav.dart';

class AppointmentPage extends StatefulWidget {
  final List<Map<String, dynamic>> appointments;

  AppointmentPage({Key? key, required this.appointments}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  int _selectedTab = 0;

  // Dummy appointment data
  final List<Map<String, dynamic>> dummyAppointments = [
    {
      'image': 'lib/assets/BS.jpeg',
      'shopName': 'Groom and Glory',
      'address': '115 P. Laurel Highway, Lipa City, Batangas, 4217',
      'date': '2024-10-30 10:00 AM',
      'price': '₱200',
      'status': 'upcoming', // Added status field
    },
    {
      'image': 'lib/assets/BS1.jpg',
      'shopName': 'Batangas Blade',
      'address': '87 San Jose Street, Batangas City, Batangas, 4200',
      'date': '2024-10-31 02:00 PM',
      'price': '₱150',
      'status': 'completed', // Added status field
    },
    {
      'image': 'lib/assets/BS2.jpg',
      'shopName': 'Elite Cuts',
      'address': '125 JP Rizal Avenue, Tanauan City, Batangas, 4232',
      'date': '2024-11-01 11:30 AM',
      'price': '₱150',
      'status': 'upcoming', // Added status field
    },
    {
      'image': 'lib/assets/BS3.jpg',
      'shopName': 'Sharp and Dapper',
      'address': 'Corner of J. Gonzales and Mabini Streets, Nasugbu, Batangas, 4231',
      'date': '2024-11-02 01:00 PM',
      'price': '₱100',
      'status': 'cancelled', // Added status field
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize appointments only once
    if (widget.appointments.isEmpty) {
      widget.appointments.addAll(dummyAppointments);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BotNavBar(
        selectedIndex: 1,
        onTap: (index) {
          // Handle bottom nav bar item taps here
          // Implement navigation logic if needed
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
                  color: Colors.black,
                ),
              ),
            ),
            _buildToggleTabs(),
            SizedBox(height: 10),
            Expanded(
              child: _buildAppointmentList(),
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
            color: isSelected ? Colors.black : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentList() {
    // Filter appointments based on the selected tab
    List<Map<String, dynamic>> filteredAppointments;
    if (_selectedTab == 0) {
      // Upcoming appointments
      filteredAppointments = widget.appointments.where((appointment) => appointment['status'] == 'upcoming').toList();
    } else if (_selectedTab == 1) {
      // Completed appointments
      filteredAppointments = widget.appointments.where((appointment) => appointment['status'] == 'completed').toList();
    } else {
      // Cancelled appointments
      filteredAppointments = widget.appointments.where((appointment) => appointment['status'] == 'cancelled').toList();
    }

    return ListView.builder(
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        return _buildAppointmentCard(filteredAppointments[index]);
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 32,
        ),
        child: Card(
          color: Colors.white,
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
                        appointment['image'] ?? 'lib/assets/default_image.jpg',
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
                            appointment['shopName'] ?? 'Unknown Shop',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            appointment['address'] ?? 'No address provided',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            appointment['date'] ?? 'No date provided',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
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
                      'Total: ${appointment['price'] ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    if (appointment['status'] == 'upcoming') // Show Cancel button only for upcoming appointments
                      ElevatedButton(
                        onPressed: () {
                          _showCancelConfirmationDialog(appointment);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          side: BorderSide(color: Colors.white),
                        ),
                        child: Text(
                          'Cancel Appointment',
                          style: TextStyle(
                            color: Colors.white,
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

  void _showCancelConfirmationDialog(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Appointment'),
          content: Text('Are you sure you want to cancel this appointment?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  appointment['status'] = 'cancelled'; // Update the appointment status
                });
                Navigator.of(context).pop(); // Close the dialog
                _showCancellationSuccessPopup(); // Show success message
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showCancellationSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Schedule Cancelled'),
          content: Text('Your appointment has been successfully cancelled.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
