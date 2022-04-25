class SignUp {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? contact;
  final String? email;
  final String? password;
  final DateTime? createdAt;

  SignUp(
      {this.id,
      this.firstName,
      this.lastName,
      this.contact,
      this.email,
      this.password,
      this.createdAt});
  factory SignUp.fromMap(Map map) {
    return SignUp(
      id: map['id'] as int,
      firstName: map['firstName'],
      lastName: map['lastName'],
      contact: map["contact"].toString(),
      email: map["email"],
      password: map["password"],
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'contact': contact,
      'email': email,
      'password': password
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'contact': contact,
      'email': email,
      'password': password,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
