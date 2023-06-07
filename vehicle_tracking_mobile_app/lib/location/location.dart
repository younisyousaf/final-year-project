// Add the 'dart:io' import statement
// ignore_for_file: avoid_print, library_private_types_in_public_api, unused_import

import 'dart:convert';
import 'dart:io';

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gm_flutter;
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as perm;

class CarLocation extends StatefulWidget {
  final String serverIP;
  final String serverPort;
  final String apiURL;

  const CarLocation({
    Key? key,
    required this.serverIP,
    required this.serverPort,
    required this.apiURL,
  }) : super(key: key);

  @override
  _CarLocationState createState() => _CarLocationState();
}

class _CarLocationState extends State<CarLocation> {
  GoogleMapController? mapController;
  List<gm_flutter.Marker> markers = [];
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
      final gm_flutter.LatLng newPosition = gm_flutter.LatLng(
          currentLocation!.latitude!, currentLocation!.longitude!);
      setState(() {
        markers = [
          gm_flutter.Marker(
            markerId: const gm_flutter.MarkerId('currentLocation'),
            position: newPosition,
          ),
        ];
        mapController
            ?.moveCamera(gm_flutter.CameraUpdate.newLatLng(newPosition));
      });
    }
  }

  Future<void> sendDataToServer() async {
    try {
      if (socket == null || socket?.write == null) {
        // Establish a new TCP connection
        socket = await Socket.connect(
          widget.serverIP,
          int.parse(widget.serverPort),
          sourceAddress: widget.apiURL,
        );
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

      if (response != null) {
        print('Server response: $response');
        print("Data is Sent to the server");
      } else {
        print("Data transmission failed");
      }
    } catch (e) {
      print('Error connecting to the server: $e');
      socket?.close();
      socket = null;
      print("Data transmission failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Vehicle Location\t\t")),
        backgroundColor: const Color.fromARGB(255, 27, 187, 1),
        leading: null,
      ),
      body: Column(
        children: [
          Expanded(
            child: gm_flutter.GoogleMap(
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: const gm_flutter.CameraPosition(
                target: gm_flutter.LatLng(27.7089427, 85.3086209),
                zoom: 14.0,
              ),
              mapType: gm_flutter.MapType.normal,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller as GoogleMapController?;
                });
              },
              markers: Set<gm_flutter.Marker>.from(markers),
            ),
          ),
        ],
      ),
    );
  }
}
