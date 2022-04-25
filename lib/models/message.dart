import 'package:near_laundry/models/user.dart';

class Message {
  final User sender;
  final DateTime time;
  final String text;
  final bool isLiked;
  final bool unread;
  final int id;

  Message(
      {required this.id,
      required this.sender,
      required this.isLiked,
      required this.text,
      required this.time,
      required this.unread});
  factory Message.fromMap(Map map) {
    return Message(
      id: map['id'] as int,
      sender: map['sender'],
      isLiked: map['isLiked'],
      unread: map["unread"],
      text: map["text"],
      time: DateTime.parse(map['time'] as String),
    );
  }

  final User currentUser = User(
    id: 0,
    name: 'Current User',
    imageUrl: 'assests/images/login.png',
  );

  final User patrick = User(
    id: 1,
    name: 'Patrick',
    imageUrl: 'assests/images/login.png',
  );

  final User yoliswa = User(
    id: 2,
    name: 'Yoliswa',
    imageUrl: 'assests/images/login.png',
  );

  final User thato = User(
    id: 3,
    name: 'Thato',
    imageUrl: 'assests/images/login.png',
  );

  final User rorisang = User(
    id: 4,
    name: 'Rorisang',
    imageUrl: 'assests/images/login.png',
  );

  final User babe = User(
    id: 5,
    name: 'Babe',
    imageUrl: 'assests/images/login.png',
  );

  final User resego = User(
    id: 6,
    name: 'Resego',
    imageUrl: 'assests/images/login.png',
  );
  final User admin = User(
    id: 7,
    name: 'Resego',
    imageUrl: 'assests/images/login.png',
  );

  late List<User> favorites = [babe, resego, yoliswa, rorisang];

  late List<Message> chats = [
    Message(
      id: 1,
      sender: babe,
      isLiked: false,
      text: 'Hi I hope you are doing well.',
      time: DateTime.now(),
      unread: true,
    ),
    Message(
      id: 2,
      sender: thato,
      isLiked: true,
      text: 'Thank you for your help :).',
      time: DateTime.now(),
      unread: true,
    ),
    Message(
      id: 3,
      sender: patrick,
      isLiked: true,
      text:
          'Time alone is useful when you are talking about multiple instances:',
      time: DateTime.now(),
      unread: true,
    ),
    Message(
      id: 4,
      sender: rorisang,
      isLiked: false,
      text: 'I have been looking for you the whole time.',
      time: DateTime.now(),
      unread: false,
    ),
    Message(
      id: 40,
      sender: currentUser,
      isLiked: false,
      text: 'Hi, Here is another method using String.Format.',
      time: DateTime.now(),
      unread: true,
    ),
    Message(
      id: 5,
      sender: babe,
      isLiked: false,
      text: 'Hi, Here is another method using String.Format.',
      time: DateTime.now(),
      unread: true,
    ),
    Message(
      id: 20,
      sender: currentUser,
      isLiked: false,
      text: 'Hi, Here is another method using String.Format.',
      time: DateTime.now(),
      unread: true,
    ),
    Message(
      id: 6,
      sender: resego,
      isLiked: false,
      text: 'Hi, For More Date and Time formatting check these links:.',
      time: DateTime.now(),
      unread: true,
    ),
    Message(
      id: 20,
      sender: currentUser,
      isLiked: false,
      text: 'Hi, Sorry i dnt understand what you are saying.',
      time: DateTime.now(),
      unread: true,
    ),
    Message(
      id: 7,
      sender: admin,
      isLiked: true,
      text: 'Hi Patrick, Reset your password.',
      time: DateTime.now(),
      unread: true,
    ),
    Message(
      id: 20,
      sender: currentUser,
      isLiked: false,
      text: 'Alright i will do that first thing tomorrow morning.',
      time: DateTime.now(),
      unread: true,
    ),
    Message(
      id: 8,
      sender: rorisang,
      isLiked: true,
      text:
          'Please consider, that a late answer is worth adding (and from other users perspective upvote)',
      time: DateTime.now(),
      unread: true,
    ),
    Message(
      id: 20,
      sender: currentUser,
      isLiked: false,
      text: 'Hi, Here is another method using String.Format.',
      time: DateTime.now(),
      unread: true,
    ),
  ];
}
