import 'dart:ffi';

class Booking {
  final int? id;
  final double? prize;
  final int? busketSize;
  final String? location;
  final String? pickUpDate;
  final String? pickUpTime;
  final String? noOfBasket;
  final DateTime? createdAt;

  Booking(
      {this.id,
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
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
