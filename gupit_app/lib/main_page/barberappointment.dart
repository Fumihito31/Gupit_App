import 'package:flutter/material.dart';
import '../components/bot_nav.dart';

class BarberAppointmentPage extends StatefulWidget {
  final List<Map<String, dynamic>> appointments;

  BarberAppointmentPage({Key? key, required this.appointments}) : super(key: key);

  @override
  _BarberAppointmentPageState createState() => _BarberAppointmentPageState();
}

class _BarberAppointmentPageState extends State<BarberAppointmentPage> {
  int _selectedTab = 0;

  // Dummy appointment data
  final List<Map<String, dynamic>> dummyAppointments = [
    {
      'image': 'lib/assets/1.jpg',
      'clientName': 'John Doe',
      'clientNumber': '09123456789',
      'clientLocation': 'Lipa City, Batangas',
      'service': 'Haircut',
      'date': '2024-10-30 10:00 AM',
      'price': '₱200',
      'status': 'upcoming',
    },
    {
      'image': 'lib/assets/2.jpg',
      'clientName': 'Jane Smith',
      'clientNumber': '09876543210',
      'clientLocation': 'Batangas City, Batangas',
      'service': 'Shave',
      'date': '2024-10-31 02:00 PM',
      'price': '₱150',
      'status': 'completed',
    },
    {
      'image': 'lib/assets/3.jpg',
      'clientName': 'Michael Johnson',
      'clientNumber': '09123456780',
      'clientLocation': 'Tanauan City, Batangas',
      'service': 'Beard Trim',
      'date': '2024-11-01 11:30 AM',
      'price': '₱150',
      'status': 'upcoming',
    },
    {
      'image': 'lib/assets/4.jpg',
      'clientName': 'Emily Davis',
      'clientNumber': '09123456781',
      'clientLocation': 'Nasugbu, Batangas',
      'service': 'Hair Color',
      'date': '2024-11-02 01:00 PM',
      'price': '₱100',
      'status': 'cancelled',
    },
  ];

  @override
  void initState() {
    super.initState();
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
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
              child: Text(
                'Appointments',
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
      filteredAppointments = widget.appointments.where((appointment) => appointment['status'] == 'upcoming').toList();
    } else if (_selectedTab == 1) {
      filteredAppointments = widget.appointments.where((appointment) => appointment['status'] == 'completed').toList();
    } else {
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
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Client: ${appointment['clientName'] ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Contact: ${appointment['clientNumber'] ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Location: ${appointment['clientLocation'] ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Service: ${appointment['service'] ?? 'N/A'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Date: ${appointment['date'] ?? 'N/A'}',
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
                    if (appointment['status'] == 'upcoming') // Show Mark as Complete button only for upcoming appointments
                      ElevatedButton(
                        onPressed: () {
                          _showConfirmationDialog(appointment);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          side: BorderSide(color: Colors.white),
                        ),
                        child: Text(
                          'Mark as Complete',
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

  void _showConfirmationDialog(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Completion'),
          content: Text('Are you sure you want to mark this appointment as completed?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _markAsCompleted(appointment); // Mark appointment as completed
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _markAsCompleted(Map<String, dynamic> appointment) {
    setState(() {
      appointment['status'] = 'completed'; // Update the appointment status
    });
    _showCompletionSuccessPopup(); // Show success message
  }

  void _showCompletionSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('The appointment has been marked as completed.'),
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
