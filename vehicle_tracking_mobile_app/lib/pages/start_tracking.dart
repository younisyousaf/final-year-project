// ignore_for_file: prefer_const_declarations, avoid_print, library_private_types_in_public_api, unnecessary_null_comparison, unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../location/location.dart';

class ServerSettingsDialog extends StatefulWidget {
  const ServerSettingsDialog({super.key});

  @override
  _ServerSettingsDialogState createState() => _ServerSettingsDialogState();
}

class _ServerSettingsDialogState extends State<ServerSettingsDialog> {
  final _formKey = GlobalKey<FormState>();
  final _storage = const FlutterSecureStorage();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Server Settings'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _ipController,
              decoration: const InputDecoration(
                labelText: 'Server IP',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the server IP';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _portController,
              decoration: const InputDecoration(
                labelText: 'Server Port',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the server port';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 31, 41, 55),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 31, 41, 55),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final ip = _ipController.text;
              final port = _portController.text;
              _saveServerSettings(ip, port);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Future<void> _saveServerSettings(String ip, String port) async {
    await _storage.write(key: 'server_ip', value: ip);
    await _storage.write(key: 'server_port', value: port);
  }
}

// Usage in your widget
void openServerSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const ServerSettingsDialog(),
  );
}

class StartTracking extends StatefulWidget {
  const StartTracking({Key? key}) : super(key: key);

  @override
  State<StartTracking> createState() => _StartTrackingState();
}

class _StartTrackingState extends State<StartTracking> {
  final _storage = const FlutterSecureStorage();
  late Timer _timer;
  late String _serverIP;
  late String _serverPort;
  late IO.Socket _socket;
  bool isTracking = false;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _stopTracking();
    super.dispose();
  }

  void _loadServerSettings() async {
    final ip = await _storage.read(key: 'server_ip');
    final port = await _storage.read(key: 'server_port');
    setState(() {
      _serverIP = ip!;
      _serverPort = port!;
    });
  }

  void _startTracking() {
    setState(() {
      isTracking = true;
    });

    _loadServerSettings();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _sendMessageToServer();
    });
  }

  void _stopTracking() {
    setState(() {
      isTracking = false;
    });
    if (_timer != null) {
      _timer.cancel();
    }
  }

  Future<String> getDeviceIdentifier() async {
    String identifier = '';

    // try {
    //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //   if (Theme.of(context).platform == TargetPlatform.android) {
    //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //     identifier = androidInfo.androidId; // Retrieves Android device ID
    //   } else if (Theme.of(context).platform == TargetPlatform.iOS) {
    //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //     identifier = iosInfo.identifierForVendor; // Retrieves iOS device ID
    //   } else {
    //     //Note: Web view will use hardcoded device IMEI
    //     identifier = '356331110282877';
    //   }
    // } catch (e) {
    //   print('Error retrieving device identifier: $e');
    // }

    return "861983055813336";
  }

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('yyyyMMddHHmmss').format(now);
    return formattedDateTime;
  }

  void _sendMessageToServer() async {
    if (_serverIP != null && _serverPort != null) {
      final imei = await getDeviceIdentifier();
      final dateTime = getCurrentDateTime();
      LocationPermission permission;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      final latitude = position.latitude;
      final longitude = position.longitude;
      final speed = position.speed.toInt();
      final heading = position.heading.toInt();
      final altitude = position.altitude.toInt();
      final satellites = 0;
      final message =
          '$imei,$dateTime,$longitude,$latitude,$speed,$heading,$altitude,$satellites';

      try {
        _socket = IO.io('http://$_serverIP:$_serverPort', <String, dynamic>{
          'transports': ['websocket'],
        });
        _socket.onConnect((_) {
          _socket.emit('message', message);
        });

        // Print the message for testing
        print('Message sent to server: $message');
      } catch (e) {
        print('Error sending message to server: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 24, 39),
        leading: null,
        automaticallyImplyLeading: false,
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(
              left: 22,
            ),
            child: Image.asset(
              'assets/images/vtrack.png',
              height: 40,
            ),
          ),
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  openServerSettingsDialog(context);
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
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(
                  // right: 90,
                  ),
              height: 50,
              width: 250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 17, 24, 39),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LiveLocation(),
                    ),
                  );
                },
                child: const Text(
                  'View Live Location!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
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
                  if (isTracking) {
                    _stopTracking();
                  } else {
                    _startTracking();
                  }
                },
                onTapDown: (details) {
                  setState(() {
                    isHovered = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isHovered = false;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: isHovered
                        ? [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundColor: const Color.fromARGB(255, 31, 41, 55),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        isTracking
                            ? '\t\t\tStop\nTracking'
                            : '\t\t\tStart\nTracking',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
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
