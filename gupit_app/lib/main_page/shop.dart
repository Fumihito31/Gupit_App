import 'package:flutter/material.dart';
import '../components/background.dart'; // Import your custom background
import '../components/bot_nav.dart'; // Import your custom Bottom Navigation Bar

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotNavBar(
        selectedIndex: 3, // Index for Shop page
        onTap: (index) {
          // Handle bottom nav bar item taps here
          // Add navigation logic based on index
        },
      ),
      body: Background( // Wrap the body in the Background widget
        child: Column(
          children: [
            SizedBox(height: 30), // For status bar padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Shop',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),

            // List of products
            Expanded(
              child: _buildProductGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    // List of sample products
    final List<Map<String, String>> products = [
      {
        'name': 'Hair Wax',
        'image': 'lib/assets/3.jpg', // Replace with your image path
        'price': '\$10'
      },
      {
        'name': 'Shampoo',
        'image': 'lib/assets/5.jpg', // Replace with your image path
        'price': '\$15'
      },
      {
        'name': 'Hair Oil',
        'image': 'lib/assets/1.jpg', // Replace with your image path
        'price': '\$12'
      },
      {
        'name': 'Comb Set',
        'image': 'lib/assets/gelo.jpg', // Replace with your image path
        'price': '\$8'
      },
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(
          products[index]['name']!,
          products[index]['image']!,
          products[index]['price']!,
        );
      },
    );
  }

  // Build product card widget
  Widget _buildProductCard(String name, String imagePath, String price) {
    return Card(
      color: Colors.blueGrey[900], // Dark background for the product card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              price,
              style: TextStyle(
                fontSize: 14,
                color: Colors.orangeAccent,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
