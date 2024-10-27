import 'package:flutter/material.dart';
import 'package:gupit_app/main_page/barber_profile.dart';

class BarbershopProfilePage extends StatelessWidget {
  final Map<String, dynamic> shop;
  final List<dynamic> barbers;

  BarbershopProfilePage({required this.shop, required this.barbers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shop['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with image and basic info
            Stack(
              children: [
                Image.asset(
                  shop['image'],
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
                        shop['name'],
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        shop['location'],
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Text(
                            '${shop['rating']}',
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
                    child: Text('OPEN', style: TextStyle(color: Colors.white)),
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
                IconButtonWithLabel(
                  icon: Icons.book,
                  label: "Book",
                  onTap: () => _bookAppointment(context, shop['name']),
                ),
              ],
            ),
            Divider(height: 32),

            // Barber specialists
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Barber Specialists", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 8),
            Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: barbers.length,
                itemBuilder: (context, index) {
                  final barber = barbers[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the BarberProfilePage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BarberProfilePage(barber: barber),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(barber['image']),
                            radius: 30,
                          ),
                          SizedBox(height: 4),
                          Text(barber['name'], style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(height: 32),

            // About section and service hours
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabButton(label: "About"),
                  SizedBox(height: 8),
                  Text(
                    shop['description'] ?? 'No description available',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  Text("Service Hours", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  ...shop['hours'].map((day) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(day['day']),
                      Text(day['time']),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _bookAppointment(BuildContext context, String shopName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Booking Confirmation"),
          content: Text("Your appointment at $shopName has been booked!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class IconButtonWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap; // Added onTap callback

  IconButtonWithLabel({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle onTap
      child: Column(
        children: [
          Icon(icon, size: 28, color: Colors.orange),
          SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String label;

  TabButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.orange,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
