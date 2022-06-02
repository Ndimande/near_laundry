import 'package:flutter/foundation.dart';

class Booking extends ChangeNotifier {
  final int? id;
  final double? prize;
  final int? busketSize;
  final String? location;
  final String? pickUpDate;
  final String? pickUpTime;
  final String? noOfBasket;
  final DateTime? createdAt;
  final int? userId;

  Booking(
      {this.id,
      this.userId,
      this.busketSize,
      this.location,
      this.noOfBasket,
      this.pickUpDate,
      this.pickUpTime,
      this.createdAt,
      this.prize});
  factory Booking.fromMap(Map map) {
    return Booking(
      id: map['id'] as int,
      busketSize: map['busketSize'],
      location: map['location'],
      noOfBasket: map["noOfBasket"].toString(),
      pickUpDate: map["pickUpDate"],
      pickUpTime: map["pickUpTime"],
      userId: map["userId"],
      prize: map["prize"],
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'busketSize': busketSize,
      'location': location,
      'noOfBasket': noOfBasket,
      'pickUpDate': pickUpDate,
      'pickUpTime': pickUpTime,
      'prize': prize,
      'userId': userId,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'busketSize': busketSize,
      'location': location,
      'noOfBasket': noOfBasket,
      'pickUpDate': pickUpDate,
      'pickUpTime': pickUpTime,
      'prize': prize,
      'userId': userId,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
