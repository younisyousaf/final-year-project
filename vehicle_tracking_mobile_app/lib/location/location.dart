// ignore_for_file: avoid_print

import 'dart:convert';
// import 'dart:html';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CarLocation extends StatefulWidget {
  const CarLocation({Key? key}) : super(key: key);

  @override
  _CarLocationState createState() => _CarLocationState();
}

class _CarLocationState extends State<CarLocation> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  bool showMap = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _startTracking() {
    setState(() {
      showMap = true;
    });
  }

  var ip;
  @override
  void initState() {
    getDirectLocation();
    super.initState();
  }

  var locationparse;
  Future getIsp() async {
    var response = await http.get(
      Uri.parse("https://api.ipify.org/"),
    );
    print(response.body);
    ip = response.body;
  }

  Future getLocation() async {
    var response = await http.get(
      Uri.parse("http://ip-api.com/json/${ip}"),
    );
    var jsonparse = json.decode(response.body);
    locationparse = jsonparse;
    print(jsonparse);
  }

  getDirectLocation() async {
    await getIsp();
    await getLocation();
  }

  void sendLocation(double latitude, double longitude) async {
    const url =
        'https://eouvt62yg2e9pky.m.pipedream.net'; // Replace with the Pipedream URL or any other temporary endpoint
    final data = {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };

    try {
      final response = await http.post(Uri.parse(url), body: data);

      if (response.statusCode == 200) {
        print('Location sent successfully');
      } else {
        print('Error sending location: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending location: $e');
    }
  }
  // void locationInfo() {
  //   Text('country:${locationparse['country']}');
  //   Text('countryCode:${locationparse['countryCode']}');
  //   Text('region:${locationparse['region']}');
  //   Text('regionName:${locationparse['regionName']}');
  //   Text('city:${locationparse['city']}');
  //   Text('timezone:${locationparse['timezone']}');
  //   Text('isp:${locationparse['isp']}');
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: showMap
            ? AppBar(
                backgroundColor: const Color.fromARGB(255, 27, 187, 1),
                title: const Center(
                  child: Text('Google Maps'),
                ),
                elevation: 2,
              )
            : null,
        body: Stack(
          children: [
            if (showMap)
              GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                // mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            // Center(
            //   child: Column(
            //     children: [

            //     ],
            //   ),
            // ),
            if (!showMap)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 250,
                      height: 400,
                      margin: const EdgeInsets.only(top: 200),
                      child: Image.asset('assets/images/Car.png'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      child: Positioned(
                        bottom: 10,
                        top: 90,
                        child: ElevatedButton(
                          onPressed: () {
                            // getIsp();
                            // getLocation();
                            getDirectLocation();
                            _startTracking();
                            sendLocation(_center.latitude, _center.longitude);
                            // locationInfo();
                          },
                          //  getIsp();,
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(40.0),
                            backgroundColor:
                                const Color.fromARGB(255, 27, 187, 1),
                          ),
                          child: const Text(
                            '\t\t\t\tStart \n Tracking',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:geojson_vi/geojson_vi.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class CarLocation extends StatelessWidget {
//   const CarLocation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   GoogleMapController? mapController;
//   List<Marker> markers = [];
//   Set<Polygon> _polygon = HashSet<Polygon>();
//   static const LatLng showLocation = LatLng(27.7089427, 85.3086209);
//   List<LatLng> points = [];
//   GeoJSONPolygon? geoJSONPolygon;
//   num? area;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(child: Text("Google Map")),
//         backgroundColor: const Color.fromARGB(255, 27, 187, 1),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: GoogleMap(
//               zoomGesturesEnabled: true,
//               myLocationButtonEnabled: true,
//               myLocationEnabled: true,
//               initialCameraPosition: const CameraPosition(
//                 target: showLocation,
//                 zoom: 15.0,
//               ),
//               mapType: MapType.normal,
//               onMapCreated: (controller) {
//                 setState(() {
//                   mapController = controller;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
