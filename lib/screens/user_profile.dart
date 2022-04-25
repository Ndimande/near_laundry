import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String name;
  final String profileImage;

  UserProfile({Key? key, required this.name, required this.profileImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(name),
        centerTitle: true,
      ),
      body: const Image(image: AssetImage('assets/images/login.png')),
    );
  }
}
