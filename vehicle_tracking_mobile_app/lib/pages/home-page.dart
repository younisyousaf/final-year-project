// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../location/add_vehicle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              // mainAxisAlignment: ,
              children: [
                profileImage(),
                Container(
                  margin: EdgeInsets.only(
                    top: 45,
                    left: 15,
                  ),
                  child: Text(
                    "Hi, Dave",
                    style: TextStyle(
                      color: Color.fromARGB(255, 27, 187, 4),
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                "Registered Vehicles",
                style: TextStyle(),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  height: 570,
                  color: Colors.greenAccent,
                ),
                Container(
                  // color: Colors.lightBlue,
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                  height: 80,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.only(
                              left: 15,
                              top: 15,
                            ),
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.carAlt,
                              size: 40,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 12, bottom: 1),
                            child: IconButton(
                              icon: Icon(
                                Icons.add_circle_rounded,
                                color: Color.fromARGB(255, 27, 187, 1),
                                size: 60,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddVehicle(),
                                  ),
                                );
                              },
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.only(right: 40, top: 10),
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings,
                              size: 45,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                            ),
                            child: Text(
                              "Garage",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 12,
                            ),
                            child: Text(
                              "Add Vehicle",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                            ),
                            child: Text(
                              "Settings",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget profileImage() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 45, left: 10),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/profile.jpeg'),
            ),
          ),
          Positioned(
            bottom: 0.1,
            left: 28.0,
            child: Icon(
              Icons.camera_alt,
              color: Color.fromARGB(255, 144, 166, 164),
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
