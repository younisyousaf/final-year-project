import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class CarLocation extends StatefulWidget {
  const CarLocation({super.key});

  @override
  State<CarLocation> createState() => _CarLocationState();
}

class _CarLocationState extends State<CarLocation> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // color: const Color.fromARGB(255, 27, 187, 1),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 27, 187, 1),
          title: const Center(
            child: Text('Google Maps'),
          ),
          elevation: 2,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
