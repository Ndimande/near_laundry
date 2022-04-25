import 'package:flutter/material.dart';
import 'package:near_laundry/widgets.dart/favorite_contact.dart';
import 'package:near_laundry/widgets.dart/recent_chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 155, 50, 137),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: const <Widget>[FavoriteContacts(), RecentChat()],
              ),
            ),
          )
        ],
      ),
    );
  }
}
