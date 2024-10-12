import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to the edit profile page or handle the edit action
            },
          ),
        ],
      ),
      body: Padding(
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                'gelo@gmail.com', // User email
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),

            Divider(),

            // Profile fields
            buildProfileField('Username', 'Gelo Paragas'),
            buildProfileField('Phone', '+123 456 789'),
            buildProfileField('Location', 'Calamba, Philippines'),
            
            Divider(),

            // Logout button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
