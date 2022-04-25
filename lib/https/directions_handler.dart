import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:near_laundry/.env.dart';

import '../models/directions.dart';

class DirectionHandler {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  final Dio _dio;
  DirectionHandler({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    @required LatLng? origin,
    @required LatLng? destination,
  }) async {
    final response = await _dio.get(_baseUrl, queryParameters: {
      'origin': '${origin?.latitude},${origin?.longitude}',
      'destination': '${destination?.latitude},${destination?.longitude}',
      'key': googleAPIKey,
    });

    //check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null as Directions; // Need to handle exeptions
  }
}
