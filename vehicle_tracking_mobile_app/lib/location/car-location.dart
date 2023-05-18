// ignore_for_file: file_names, prefer_const_constructors, avoid_init_to_null

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vehicle_tracking_mobile_app/location/directions_repository.dart';
import 'package:vehicle_tracking_mobile_app/models/directions_model.dart';

class CarLocation extends StatefulWidget {
  const CarLocation({Key? key}) : super(key: key);

  @override
  State<CarLocation> createState() => _CarLocationState();
}

class _CarLocationState extends State<CarLocation> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(34.42364292120022, 73.24691846768684),
    zoom: 11.5,
  );

  late GoogleMapController _googleMapController;
  Marker? _origin; // Make _origin nullable
  Marker? _destination; // Make _destination nullable
  late Directions? _info = null;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Google Map"),
        backgroundColor: Color.fromARGB(255, 27, 187, 1),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text(
                "Origin",
                style: TextStyle(color: Colors.white),
              ),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text(
                "Destination",
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_origin != null) _origin!,
              if (_destination != null) _destination!,
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
            onLongPress: _addMarker,
          ),
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 2),
                        blurRadius: 6.0),
                  ],
                ),
                child: Text(
                  '${_info!.totalDistance}, ${_info!.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: const Icon(
          Icons.directions_car,
          size: 40,
        ),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_destination != null) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        _destination = null; // Clear _destination if _origin is set
        _info = null;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      //Get Directions
      final dio = Dio(BaseOptions(
          baseUrl: 'https://maps.googleapis.com/maps/api/directions'));
      final directions = await DirectionsRepository(dio: dio)
          .getDirections(origin: _origin!.position, destination: pos);

      setState(() => _info = directions!);
    }
  }
}
