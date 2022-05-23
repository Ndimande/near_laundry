import 'dart:io';
import 'package:near_laundry/models/booking.dart';
import 'package:near_laundry/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/sign_up.dart';

class DatabaseHelper {
  DatabaseHelper._privateContructor();
  static final DatabaseHelper instance = DatabaseHelper._privateContructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'laundry.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE signup(
        id INTEGER PRIMARY KEY,
        firstName TEXT,
        lastName TEXT,
        contact INTEGER,
        email TEXT,
        password TEXT,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
      )
        
     ''');

    await db.execute(''' 
      CREATE TABLE admin(
        id INTEGER PRIMARY KEY,
        firstName TEXT,
        lastName TEXT,
        contact INTEGER,
        email TEXT,
        password TEXT,
        company_name TEXT,
        location TEXT,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
      )
     ''');

    await db.execute('''
        CREATE TABLE booking(
        id INTEGER PRIMARY KEY,
        prize REAL,
        busketSize INTEGER,
        location INTEGER,
        pickUpDate TEXT,
        pickUpTime TEXT,
        noOfBasket INTEGER,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
        user_id INTEGER, 
        FOREIGN KEY (user_id) REFERENCES signup (id)
       
      )
     ''');
  }

  Future<List<SignUp>> getRegisteredUsers() async {
    Database db = await instance.database;
    var users = await db.query('signup', orderBy: 'firstName');
    List<SignUp> usersList =
        users.isNotEmpty ? users.map((u) => SignUp.fromMap(u)).toList() : [];
    return usersList;
  }

  Future<List<Booking>> getAllBookings() async {
    Database db = await instance.database;
    var bookings = await db.query('booking', orderBy: 'createdAt');
    List<Booking> bookingList = bookings.isNotEmpty
        ? bookings.map((b) => Booking.fromMap(b)).toList()
        : [];
    return bookingList;
  }

  Future<List<Booking>> getBookingsByUserId(int? id) async {
    Database db = await instance.database;
    var bookings =
        await db.query('booking', orderBy: 'createdAt', where: 'id = $id');
    List<Booking> bookingList = bookings.isNotEmpty
        ? bookings.map((b) => Booking.fromMap(b)).toList()
        : [];
    return bookingList;
  }

  Future<List<Map<String, dynamic>>> getLoggedInUserById(int? id) async {
    Database db = await instance.database;
    return await db.rawQuery(
      'SELECT id from signup where id = $id',
    );
  }

//This delete is generic
  Future<void> delete(String table, int? id) async {
    Database db = await instance.database;
    await db.rawDelete('DELETE FROM $table WHERE id = $id');
  }

  Future<int> addBook(Booking book) async {
    Database db = await instance.database;
    return await db.insert(
      'booking',
      book.toMap(),
    );
  }

  Future<int> add(SignUp user) async {
    Database db = await instance.database;
    return await db.insert(
      'signup',
      user.toMap(),
    );
  }
}
