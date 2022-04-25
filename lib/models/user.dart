class User {
  final int id;
  final String name;
  final String imageUrl;

  User({required this.id, required this.name, required this.imageUrl});
  factory User.fromMap(Map map) {
    return User(
      id: map['id'] as int,
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }
}
