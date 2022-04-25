import 'package:flutter/material.dart';
import '../models/message.dart';
import '../models/user.dart';
import '../screens/message_screen.dart';

class FavoriteContacts extends StatelessWidget {
  const FavoriteContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Message _msg = Message(
        id: 0,
        isLiked: true,
        sender: User(id: 0, name: '', imageUrl: ''),
        text: '',
        time: DateTime.now(),
        unread: true);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10.0),
            itemCount: _msg.favorites.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MessageScreen(user: _msg.favorites[index]),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 35.0,
                          backgroundImage:
                              AssetImage('assets/images/login.png'),
                        ),
                      ),
                      Text(
                        _msg.favorites[index].name,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 16.0),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
