import 'package:flutter/material.dart';
import 'package:near_laundry/models/message.dart';

import '../models/user.dart';

class MessageScreen extends StatefulWidget {
  final User user;
  const MessageScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

_buildMessage(Message message, bool isMe, BuildContext context) {
  final Container msg = Container(
    width: MediaQuery.of(context).size.width * 0.75,
    margin: isMe
        ? const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
        : const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
          ),
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
    decoration: BoxDecoration(
      color: isMe
          ? const Color(0x0fffefee)
          : const Color.fromARGB(255, 248, 230, 165),
      borderRadius: isMe
          ? const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
            )
          : const BorderRadius.only(
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
    ),
    child:
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Text(
        "${message.time.hour}:${message.time.minute}:${message.time.second}",
        style: const TextStyle(
            color: Color.fromARGB(255, 19, 18, 18),
            fontWeight: FontWeight.w600,
            fontSize: 16.0),
      ),
      const SizedBox(
        height: 5.0,
      ),
      Text(
        message.text,
        style: const TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.w600,
            fontSize: 16.0),
      )
    ]),
  );
  if (isMe) {
    return msg;
  }
  return Row(
    children: [
      msg,
      IconButton(
        onPressed: () {},
        icon: message.isLiked
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : Icon(
                Icons.favorite_border,
                color: message.isLiked ? Colors.red : Colors.blueGrey,
              ),
      )
    ],
  );
}

_buildMessageComposer() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    color: Colors.white,
    child: Row(children: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.photo,
          size: 20.0,
          color: Colors.grey,
        ),
      ),
      const Expanded(
          child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(hintText: 'Send a message'),
      )),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.send,
          size: 20.0,
          color: Colors.grey,
        ),
      )
    ]),
  );
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    Message _msg = Message(
        id: 0,
        isLiked: true,
        sender: User(id: 0, name: '', imageUrl: ''),
        text: '',
        time: DateTime.now(),
        unread: true);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.user.name,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 155, 50, 137),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.only(top: 15.0),
                    itemCount: _msg.chats.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = _msg.chats[index];
                      final bool isMe =
                          message.sender.id == _msg.currentUser.id;
                      return _buildMessage(message, isMe, context);
                    }),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
