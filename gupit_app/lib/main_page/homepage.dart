import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gupit_app/main_page/AllItemsPage.dart';
import '../components/bot_nav.dart';
import 'shop.dart';
import 'barber_profile.dart'; // Import your barber profile page
import 'barbershop_profile.dart'; // Import your barbershop profile page
import 'product_profile.dart'; // Import your product profile page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<dynamic> _barbershops = [];
  List<dynamic> _popularBarbers = [];
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    _loadBarbershopsData();
    _loadPopularBarbersData();
    _loadProductsData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("Tapped item at index: $index"); // Debug print for clicks
  }

  Future<void> _loadBarbershopsData() async {
    final String response = await rootBundle.loadString('lib/dummydata/barbershops.json');
    final data = await json.decode(response);
    setState(() {
      _barbershops = data['barbershops'];
    });
  }

  Future<void> _loadPopularBarbersData() async {
    final String response = await rootBundle.loadString('lib/dummydata/barbers.json');
    final data = await json.decode(response);
    setState(() {
      _popularBarbers = data['barbers'];
    });
  }

  Future<void> _loadProductsData() async {
    final String response = await rootBundle.loadString('lib/dummydata/products.json');
    final Map<String, dynamic> data = json.decode(response);

    // Flatten the product categories into a single list
    List<dynamic> allProducts = [];
    data['products'].forEach((key, value) {
      if (value is List) {
        allProducts.addAll(value);
      }
    });

    print("Loaded products: $allProducts"); // Debug print to check loaded products
    setState(() {
      _products = allProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImageBanner(),
              SizedBox(height: 20),

              buildSectionHeader("Recommended Shops Near Me", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllItemsPage(items: _barbershops, title: 'All Barbershops')),
                );
              }),
              buildHorizontalBarberList(_barbershops),

              SizedBox(height: 20),

              buildSectionHeader("Most Popular Shops", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllItemsPage(items: _barbershops, title: 'Most Popular Shops')),
                );
              }),
              buildHorizontalBarberList(_barbershops),

              SizedBox(height: 20),

              buildSectionHeader("Popular Barbers", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllItemsPage(items: _popularBarbers, title: 'Popular Barbers')),
                );
              }),
              buildHorizontalPopularBarbersList(),

              SizedBox(height: 20),

              buildSectionHeader("Featured Products", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopPage()),
                );
              }),
              buildProductsCarousel(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BotNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildImageBanner() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('lib/assets/BS1.jpg'),
          fit: BoxFit.cover,
          onError: (error, stackTrace) => print("Error loading image: $error"),
        ),
      ),
    );
  }

  Widget buildSectionHeader(String title, VoidCallback onShowMore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        TextButton(
          onPressed: onShowMore,
          child: Text(
            "Show More",
            style: TextStyle(color: Colors.orangeAccent),
          ),
        ),
      ],
    );
  }

  Widget buildHorizontalBarberList(List<dynamic> barbershops) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: barbershops.length,
        itemBuilder: (context, index) {
          final shop = barbershops[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BarbershopProfilePage(shop: shop, barbers: [])), // Navigate to the barbershop profile
              );
            },
            child: buildBarberTile(shop),
          );
        },
      ),
    );
  }

  Widget buildHorizontalPopularBarbersList() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _popularBarbers.length,
        itemBuilder: (context, index) {
          final barber = _popularBarbers[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BarberProfilePage(barber: barber)), // Navigate to the barber profile
              );
            },
            child: buildPopularBarberTile(barber),
          );
        },
      ),
    );
  }

  Widget buildBarberTile(dynamic shop) {
    return Container(
      width: 220,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(0, 6),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    shop['image'],
                    width: 200,
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, color: Colors.black, size: 50);
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    color: Colors.white.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: Text(
                      '⭐ ${shop['rating'] ?? 'N/A'}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              shop['name'],
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              shop['location']?.length > 20 
                ? '${shop['location']?.substring(0, 20)}...' 
                : shop['location'] ?? '',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPopularBarberTile(dynamic barber) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              barber['image'],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, color: Colors.black, size: 50);
              },
            ),
          ),
          SizedBox(height: 4),
          Text(
            barber['name'],
            style: TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget buildProductsCarousel() {
    if (_products.isEmpty) {
      return Center(
        child: CircularProgressIndicator(), // Loading indicator
      );
    }

    return CarouselSlider.builder(
      itemCount: _products.length,
      itemBuilder: (context, index, realIndex) {
        final product = _products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductProfilePage(id: product['id'])), // Navigate to the product profile
            );
          },
          child: buildProductItem(product),
        );
      },
      options: CarouselOptions(
        height: 180,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget buildProductItem(dynamic product) {
    return Container(
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
            child: Image.asset(
              product['image'],
              width: 150,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, color: Colors.black, size: 50);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '₦${product['price']}',
                  style: TextStyle(color: Colors.orange),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
