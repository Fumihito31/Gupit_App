import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../components/background.dart';
import '../components/bot_nav.dart';
import 'package:carousel_slider/carousel_slider.dart'; // For carousel functionality

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
    final data = await json.decode(response);

    setState(() {
      // Flatten all categories into a single list
      _products = (data['products'] as Map<String, dynamic>)
          .values
          .expand((category) => category)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildImageBanner(),
                SizedBox(height: 20),

                buildSectionTitle("Recommended Shops Near Me"),
                buildBarberList(_barbershops.where((shop) => shop['recommended'] == true).toList()),

                SizedBox(height: 20),

                buildSectionTitle("Most Popular Shops"),
                buildBarberList(_barbershops.where((shop) => shop['rating'] > 4.5).toList()),

                SizedBox(height: 20),

                buildSectionTitle("Popular Barbers"),
                buildPopularBarbersList(),

                SizedBox(height: 20),

                buildSectionTitle("Featured Products"),
                buildProductsCarousel(),
              ],
            ),
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
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget buildBarberList(List<dynamic> barbershops) {
    return Column(
      children: barbershops.map((shop) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(shop['image'], width: 50, height: 50, fit: BoxFit.cover),
          ),
          title: Text(shop['name'], style: TextStyle(color: Colors.white)),
          subtitle: Text(shop['location'], style: TextStyle(color: Colors.white70)),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
            onPressed: () {},
            child: Text('Book', style: TextStyle(color: Colors.black)),
          ),
        );
      }).toList(),
    );
  }

  Widget buildPopularBarbersList() {
    return Column(
      children: _popularBarbers.map((barber) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(barber['image'], width: 50, height: 50, fit: BoxFit.cover),
          ),
          title: Text(barber['name'], style: TextStyle(color: Colors.white)),
          subtitle: Text(
            barber['specialty'] ?? 'Specialty not available',
            style: TextStyle(color: Colors.white70),
          ),

          trailing: Text('${barber['rating']} ⭐', style: TextStyle(color: Colors.orangeAccent)),
        );
      }).toList(),
    );
  }

  Widget buildProductsCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: _products.map((product) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(product['image'], width: 60, height: 60, fit: BoxFit.cover),
                  SizedBox(height: 10),
                  Text(
                    product['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '₱${product['price']}',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
