// Add the 'dart:io' import statement
// ignore_for_file: avoid_print, library_private_types_in_public_api, unused_import

import 'dart:convert';
import 'dart:io';

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gm_flutter;
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as perm;
import 'package:signalr_netcore/signalr_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LiveLocation extends StatefulWidget {
  const LiveLocation({
    Key? key,
  }) : super(key: key);

  @override
  _LiveLocationState createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {
  GoogleMapController? mapController;
  List<gm_flutter.Marker> markers = [];
  LocationData? currentLocation;
  Location location = Location();
  final _serverUrl = "localhost:3001/signalr";
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    final httpConnectionOptions = HttpConnectionOptions(
        transport: HttpTransportType.WebSockets,
        accessTokenFactory: () => getAccessToken());

    final hubConnection = HubConnectionBuilder()
        .withUrl(_serverUrl, options: httpConnectionOptions)
        .withAutomaticReconnect(
            retryDelays: [2000, 5000, 10000, 20000]).build();
    hubConnection.start();
    hubConnection.on("GetAll", _handleAClientProvidedFunction);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleAClientProvidedFunction(List<Object?>? parameters) {
    print(parameters);
  }

  Future<String> getAccessToken() async {
    final token = await _storage.read(key: 'access_token');
    if (token == null) {
      return "";
    }
    return token;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Live Tracking\t\t")),
        backgroundColor: const Color.fromARGB(255, 31, 41, 55),
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
