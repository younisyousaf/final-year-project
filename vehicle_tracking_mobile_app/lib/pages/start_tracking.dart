// ignore_for_file: prefer_const_declarations, avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:vehicle_tracking_mobile_app/location/location.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:location/location.dart' as loc;

class StartTracking extends StatefulWidget {
  const StartTracking({Key? key}) : super(key: key);

  @override
  State<StartTracking> createState() => _StartTrackingState();
}

class _StartTrackingState extends State<StartTracking> {
  String serverIP = '';
  String serverPort = '';
  String apiURL = '';

  loc.LocationData? currentLocation;
  loc.Location location = loc.Location();
  Socket? socket;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    final permission_handler.PermissionStatus status =
        await permission_handler.Permission.location.request();
    if (status != permission_handler.PermissionStatus.granted) {
      print("Location Permission is not Granted!, Turn on Your Location");
    } else {
      // location.onLocationChanged.listen((loc.LocationData? locationData) {
      //   setState(() {
      //     currentLocation = locationData;
      //     sendDataToServer();
      //   });
      // });
    }
  }

  Future<void> sendDataToServer() async {
    if (serverIP.isEmpty || serverPort.isEmpty) {
      print('Please enter server IP and Port');
      return;
    }

    try {
      if (socket == null || socket?.write == null) {
        socket = await Socket.connect(serverIP, int.parse(serverPort));
      }

      final imei = '356331110282877';
      final dateTime = DateTime.now().toString();
      final latitude = currentLocation?.latitude ?? 44.82398238;
      final longitude = currentLocation?.longitude ?? 23.472798279;
      final speed = currentLocation?.speed ?? 12.0;
      final heading = currentLocation?.heading ?? 34.48983;
      final altitude = currentLocation?.altitude ?? 33.3939274927;

      final dataString =
          '$imei,$dateTime,$latitude,$longitude,$speed,$heading,$altitude';

      print('Sending data to server: $serverIP:$serverPort, Data: $dataString');

      socket?.write(dataString);

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
  void dispose() {
    socket?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 187, 1),
        leading: null,
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return Builder(
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Server Setting',
                              textAlign: TextAlign.center,
                            ),
                            contentPadding: const EdgeInsets.all(16.0),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            setState(() {
                                              apiURL = value;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Server Address',
                                            labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 27, 187, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            setState(() {
                                              serverIP = value;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Server IP',
                                            labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 27, 187, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            setState(() {
                                              serverPort = value;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Server Port',
                                            labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 27, 187, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 27, 187, 1),
                                    ),
                                    onPressed: () {
                                      // Perform any validation or saving logic for server IP and Port
                                      Navigator.of(dialogContext).pop();
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.settings),
                iconSize: 35,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SizedBox(
                width: 250,
                child: Image.asset('assets/images/Car.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CarLocation(
                        serverIP: '',
                        serverPort: '',
                        apiURL: '',
                      ),
                    ),
                  );
                },
                child: const CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Color.fromARGB(255, 27, 187, 1),
                  child: Text(
                    "\t\t\tStart \nTracking",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
