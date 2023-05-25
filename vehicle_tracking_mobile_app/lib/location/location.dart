// Add the 'dart:io' import statement
// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as perm;

class CarLocation extends StatefulWidget {
  final String serverIP;
  final String serverPort;

  const CarLocation({
    Key? key,
    required this.serverIP,
    required this.serverPort,
  }) : super(key: key);

  @override
  _CarLocationState createState() => _CarLocationState();
}

class _CarLocationState extends State<CarLocation> {
  GoogleMapController? mapController;
  List<Marker> markers = [];
  LocationData? currentLocation;
  Location location = Location();
  StreamSubscription<LocationData>? locationSubscription;
  Socket? socket;

  @override
  void initState() {
    super.initState();
    checkLocationPermissions();
    locationSubscription =
        location.onLocationChanged.listen((LocationData locationData) {
      setState(() {
        currentLocation = locationData;
        updateMarker();
        sendDataToServer();
      });
    });
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    socket?.close();
    super.dispose();
  }

  Future<void> checkLocationPermissions() async {
    final perm.PermissionStatus status =
        await perm.Permission.location.request();
    if (status != perm.PermissionStatus.granted) {
      print("Your Location is not granted, Turn on your Location");
    }
  }

  void updateMarker() {
    if (currentLocation != null) {
      final LatLng newPosition =
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      setState(() {
        markers = [
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: newPosition,
          ),
        ];
        mapController?.animateCamera(CameraUpdate.newLatLng(newPosition));
      });
    }
  }

  Future<void> sendDataToServer() async {
    try {
      if (socket == null || socket?.write == null) {
        // Establish a new TCP connection
        socket =
            await Socket.connect(widget.serverIP, int.parse(widget.serverPort));
      }

      final locationData = currentLocation!;
      final data =
          'Location: ${locationData.latitude},${locationData.longitude}';

      // Send data to the server
      socket?.write(data);

      // Optionally, wait for a response from the server
      final response = await socket
          ?.transform(utf8.decoder as StreamTransformer<Uint8List, dynamic>)
          .join();
      print('Server response: $response');
    } catch (e) {
      print('Error connecting to the server: $e');
      socket?.close();
      socket = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Vehicle Tracking")),
        backgroundColor: const Color.fromARGB(255, 27, 187, 1),
        leading: null,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              zoomGesturesEnabled: true,
              initialCameraPosition: const CameraPosition(
                target: LatLng(27.7089427, 85.3086209),
                zoom: 15.0,
              ),
              mapType: MapType.normal,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              markers: Set<Marker>.from(markers),
            ),
          ),
        ],
      ),
    );
  }
}
