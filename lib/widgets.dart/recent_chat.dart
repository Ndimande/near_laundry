import 'package:flutter/material.dart';
import 'package:near_laundry/screens/message_screen.dart';
import '../models/message.dart';
import '../models/user.dart';

class RecentChat extends StatelessWidget {
  const RecentChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Message _msg = Message(
        id: 0,
        isLiked: true,
        sender: User(id: 1, name: '', imageUrl: ''),
        text: '',
        time: DateTime.now(),
        unread: true);
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 10.0),
            itemCount: _msg.chats.length,
            itemBuilder: (BuildContext context, int index) {
              final Message chat = _msg.chats[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MessageScreen(user: chat.sender))),
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 5.0, bottom: 5.0, right: 20.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      color:
                          chat.unread ? const Color(0x0fffefee) : Colors.white,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 10.0,
                            ),
                            const CircleAvatar(
                              radius: 35.0,
                              backgroundImage:
                                  AssetImage('assets/images/login.png'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  chat.sender.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  child: Text(
                                    chat.text,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(children: <Widget>[
                          Text(
                            "${chat.time.hour}:${chat.time.minute}:${chat.time.second}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          chat.unread
                              ? Container(
                                  width: 40,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.red),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'New',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : const Text(''),
                        ]),
                      ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
