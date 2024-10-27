import 'dart:convert';
import 'package:flutter/material.dart';
import '../components/background.dart'; // Import your custom background
import '../components/bot_nav.dart'; // Import your custom Bottom Navigation Bar
import 'product_profile.dart'; // Import the product profile page

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<dynamic> products = [];
  List<dynamic> cart = [];
  List<bool> selectedItems = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    String data = await DefaultAssetBundle.of(context).loadString('lib/dummydata/products.json');
    final jsonData = json.decode(data);

    products = (jsonData['products'] as Map<String, dynamic>).values
        .expand((category) => category as List<dynamic>)
        .toList();

    setState(() {});
  }

  void _addToCart(product) {
    setState(() {
      cart.add(product);
      selectedItems.add(false); // Initialize selection state for the new product
    });
  }

  void _showCart() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Ensure selectedItems matches the cart length
        if (selectedItems.length < cart.length) {
          selectedItems = List<bool>.filled(cart.length, false);
        }

        return AlertDialog(
          title: Text("Your Cart"),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView( // Add scrollable behavior
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true, // Take only the needed space
                    physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Row(
                          children: [
                            Image.asset(cart[index]['image'], height: 50, width: 50, fit: BoxFit.cover),
                            SizedBox(width: 10),
                            // Show only the first 10 characters of the product name
                            Text(
                              cart[index]['name'].length > 10 
                                  ? cart[index]['name'].substring(0, 10) + '...' 
                                  : cart[index]['name'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        subtitle: Text('₱ ${cart[index]['price']}', style: TextStyle(color: Colors.orange)), 
                        value: selectedItems[index],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedItems[index] = value!;
                          });
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () => _confirmPurchase(),
                      child: Text("Purchase"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _confirmPurchase() {
    List<dynamic> selectedProducts = [];
    for (int i = 0; i < cart.length; i++) {
      if (selectedItems[i]) {
        selectedProducts.add(cart[i]);
      }
    }

    if (selectedProducts.isEmpty) {
      _showMessage("Please select at least one product to purchase.");
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String paymentMethod = "COD"; // Default to COD
        String location = "";

        return AlertDialog(
          title: Text("Purchase Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Choose payment method:"),
              ListTile(
                title: Text("Cash on Delivery (COD)"),
                leading: Radio(
                  value: "COD",
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value.toString();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("Online Payment"),
                leading: Radio(
                  value: "Online",
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value.toString();
                    });
                  },
                ),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Enter your location"),
                onChanged: (value) {
                  location = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (location.isEmpty) {
                  _showMessage("Please enter your location.");
                } else {
                  Navigator.of(context).pop();
                  _showMessage("Transaction successful for ${selectedProducts.length} products!");
                }
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        maxWidth: 20,
                        maxHeight: 20,
                      ),
                      child: Text(
                        '${cart.length}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: _showCart,
          ),
        ],
      ),
      bottomNavigationBar: BotNavBar(
        selectedIndex: 3, // Index for Shop page
        onTap: (index) {
          // Handle bottom nav bar item taps here
          // Add navigation logic based on index
        },
      ),
      body: Container(
        color: Colors.white,
        child: products.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView( // Wrap Column with SingleChildScrollView
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 30), // For status bar padding
                      Text(
                        'Shop',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      // List of products
                      _buildProductGrid(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(), // Prevents GridView from scrolling
      shrinkWrap: true, // Makes GridView take only the space it needs
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  // Build product card widget
  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        // Navigate to product profile page and pass the product ID
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductProfilePage(id: product['id']),
          ),
        );
      },
      child: Card(
        color: Colors.white, // Set the card color to white
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: EdgeInsets.all(0), // Remove default margin
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                product['image'],
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                product['name'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis, // Prevent overflow
              ),
              SizedBox(height: 5),
              Text(
                '₱ ${product['price']}',
                style: TextStyle(fontSize: 14, color: Colors.orange), // Change color to orange
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () => _addToCart(product),
                child: Text("Add to Cart"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
