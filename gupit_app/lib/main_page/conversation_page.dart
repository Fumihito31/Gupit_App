import 'package:flutter/material.dart';
import '../components/background.dart'; // Import your background.dart for the black background

class ConversationPage extends StatelessWidget {
  final String barberName;

  const ConversationPage(this.barberName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          barberName,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Background( // Apply black background
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    buildMessage('Hi, how are you?', true),
                    buildMessage('I’m good, thank you! How about you?', false),
                    buildMessage('Looking forward to our appointment!', true),
                    buildMessage('Me too! See you then.', false),
                  ],
                ),
              ),
              buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessage(String text, bool isSentByMe) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSentByMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // Handle send message action
            },
          ),
        ],
      ),
    );
  }
}
