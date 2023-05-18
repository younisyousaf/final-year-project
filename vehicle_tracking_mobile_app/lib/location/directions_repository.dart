// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/directions_model.dart';

import '.env.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({required Dio dio}) : _dio = dio;

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': googleAPIKey,
        },
      );
      // Check if response is successful
      if (response.statusCode == 200) {
        return Directions.fromMap(response.data);
      }
    } catch (e) {
      print('Error getting directions: $e');
    }
    return null;
  }
}
