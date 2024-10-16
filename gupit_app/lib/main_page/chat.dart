import 'package:flutter/material.dart';
import '../components/background.dart'; // Import your background.dart for the black background
import '../components/bot_nav.dart'; // Import your bottom navigation bar widget
import 'conversation_page.dart'; // Import the conversation page

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _selectedIndex = 2; // Default to Chat tab index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected tab index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background( // Apply black background
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Online Barber',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildOnlineBarber('lib/assets/1.jpg', 'Darleen B'),
                    buildOnlineBarber('lib/assets/2.jpg', 'Edward P'),
                    buildOnlineBarber('lib/assets/3.jpg', 'Jay T Shores'),
                    buildOnlineBarber('lib/assets/4.jpg', 'Thomas M'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Recent Chats',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    buildRecentChat('lib/assets/1.jpg', 'Leslie S Klock', 'Thank you for your information', '9:59 PM'),
                    buildRecentChat('lib/assets/2.jpg', 'Edward P Thomas', 'Cool bro, see you next week!', '9:59 PM'),
                    buildRecentChat('lib/assets/3.jpg', 'Jay T Shores', 'Okay.', '9:59 PM'),
                    buildRecentChat('lib/assets/4.jpg', 'Thomas M Rodriquez', 'Good game, well played!', '9:59 PM'),
                    buildRecentChat('lib/assets/5.jpg', 'Chris L Huertas', 'See you soon..', '9:59 PM'),
                  ],
                ),
              ),
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

  Widget buildOnlineBarber(String imagePath, String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 5),
          Text(name, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget buildRecentChat(String imagePath, String name, String message, String time) {
    return ListTile(
      onTap: () {
        // Navigate to the conversation page when a chat is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationPage(name),
          ),
        );
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(name, style: TextStyle(color: Colors.white)),
      subtitle: Text(message, style: TextStyle(color: Colors.white70)),
      trailing: Text(time, style: TextStyle(color: Colors.white70)),
    );
  }
}
