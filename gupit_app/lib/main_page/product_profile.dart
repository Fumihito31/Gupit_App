import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ProductProfilePage extends StatefulWidget {
  final int id;

  ProductProfilePage({required this.id});

  @override
  _ProductProfilePageState createState() => _ProductProfilePageState();
}

class _ProductProfilePageState extends State<ProductProfilePage> {
  Map<String, dynamic>? _product;
  List<dynamic> _suggestedProducts = []; // Placeholder for suggested products

  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  Future<void> _loadProductData() async {
    try {
      final String response = await rootBundle.loadString('lib/dummydata/products.json');
      final data = json.decode(response);

      // Find the product by its ID and also determine its category
      for (var category in data['products'].keys) {
        for (var product in data['products'][category]) {
          if (product['id'] == widget.id) {
            setState(() {
              _product = product;
            });

            // Load suggested products from the same category
            _loadSuggestedProducts(data['products'][category], widget.id);
            return;
          }
        }
      }
    } catch (e) {
      // Handle JSON loading errors
      print("Error loading product data: $e");
    }
  }

  void _loadSuggestedProducts(List<dynamic> categoryProducts, int currentProductId) {
    // Filter products from the same category, excluding the current product
    setState(() {
      _suggestedProducts = categoryProducts
          .where((product) => product['id'] != currentProductId)
          .toList()
          .take(4) // Show only a few suggested products
          .toList();
    });
  }

  void _navigateToProductProfile(int productId) {
    // Navigate to the product profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductProfilePage(id: productId),
      ),
    );
  }

  void _addToCart() {
    // Implement add to cart functionality
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Added to Cart"),
          content: Text("${_product!['name']} has been added to your cart."),
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

  @override
  Widget build(BuildContext context) {
    if (_product == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Product Details")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_product!['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: MediaQuery.of(context).size.height * 0.35, // Set height relative to screen height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  _product!['image'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Product Name and Price
            Text(
              _product!['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              "\₱${_product!['price']}",
              style: TextStyle(fontSize: 20, color: Colors.orange),
            ),
            SizedBox(height: 16.0),
            // Product Description
            Text(
              _product!['description'],
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 24.0),
            // Add to Cart Button
            ElevatedButton(
              onPressed: _addToCart,
              child: Text("Add to Cart"),
            ),
            SizedBox(height: 24.0),
            // Suggested Products Section
            Text("Suggested Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),
            // Suggested Products List
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _suggestedProducts.length,
                itemBuilder: (context, index) {
                  final product = _suggestedProducts[index];
                  return GestureDetector(
                    onTap: () => _navigateToProductProfile(product['id']),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(product['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(product['name'], textAlign: TextAlign.center),
                          Text("\₱${product['price']}", style: TextStyle(color: Colors.orange)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
