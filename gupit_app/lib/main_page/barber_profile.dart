import 'package:flutter/material.dart';
import 'package:gupit_app/main_page/booking_page.dart';

class BarberProfilePage extends StatelessWidget {
  final Map<String, dynamic> barber;

  BarberProfilePage({required this.barber}); // Removed null check

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(barber['name']),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with image and basic info
            Stack(
              children: [
                Image.asset(
                  barber['image'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        barber['name'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 1),
                            Shadow(color: Colors.black, offset: Offset(-1, -1), blurRadius: 1),
                            Shadow(color: Colors.black, offset: Offset(1, -1), blurRadius: 1),
                            Shadow(color: Colors.black, offset: Offset(-1, 1), blurRadius: 1),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            barber['location'] ?? 'No location',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          SizedBox(width: 4),
                          Text(
                            '${barber['rating']}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.green,
                    child: Text('Available', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButtonWithLabel(icon: Icons.language, label: "Website"),
                IconButtonWithLabel(icon: Icons.call, label: "Call"),
                IconButtonWithLabel(icon: Icons.map, label: "Direction"),
                GestureDetector(
                  onTap: () {
                    // Navigate to the booking page directly
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingPage(barber: barber)),
                    );
                  },
                  child: IconButtonWithLabel(icon: Icons.book, label: "Book"),
                ),
              ],
            ),
            Divider(height: 32),

            // Services offered
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Services Offered", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: barber['services'].length,
              itemBuilder: (context, index) {
                final service = barber['services'][index];
                return ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.orange),
                  title: Text(service['name']),
                  trailing: Text('₱${service['price']}'),
                );
              },
            ),
            Divider(height: 32),

            // About section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About ${barber['name']}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                    barber['description'] ?? 'No description available',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  Text("Availability", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  ...barber['availability'].map((day) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(day['day']),
                      Text(day['time']),
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class IconButtonWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  IconButtonWithLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.orange),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}
