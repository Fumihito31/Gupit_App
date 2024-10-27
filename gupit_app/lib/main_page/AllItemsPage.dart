import 'package:flutter/material.dart';
import 'barber_profile.dart';  // Import the barber profile page
import 'barbershop_profile.dart';  // Import the barbershop profile page
import 'shop.dart';  // Import the shop page for products

class AllItemsPage extends StatelessWidget {
  final List<dynamic> items;
  final String title;

  AllItemsPage({required this.items, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item['image'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.broken_image, color: Colors.black, size: 50);
                },
              ),
            ),
            title: Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              item['location'] ?? '',
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              item.containsKey('rating') ? '⭐ ${item['rating']}' : '',
              style: TextStyle(color: Colors.orangeAccent),
            ),
            onTap: () {
              // Determine the type of item clicked and navigate accordingly
              if (item['type'] == 'barber') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BarberProfilePage(barber: item),
                  ),
                );
              } else if (item['type'] == 'barbershop') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BarbershopProfilePage(shop: item, barbers: []), // Pass barbers if available
                  ),
                );
              } else if (item['type'] == 'product') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopPage(), // Navigate to the shop page
                  ),
                );
              } else {
                // Show an error message if the item type is unrecognized
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Unrecognized item type')),
                );
              }
            },
          );
        },
      ),
    );
  }
}
