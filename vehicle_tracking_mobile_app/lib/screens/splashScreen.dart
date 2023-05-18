// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:vehicle_tracking_mobile_app/pages/signup.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 220, bottom: 20),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(255, 260),
                  bottomRight: Radius.elliptical(80, 10),
                ),
                color: Color.fromARGB(255, 27, 187, 1),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            SizedBox(
              // height: 250.0,
              width: 260.0,
              child: Image.asset(
                'assets/images/Car.png',
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 50)),
                Text(
                  "Locate your",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "vehicle",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "without Noise\n",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 27, 187, 1),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 370,
              height: 60,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 27, 187, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // <-- Radius
                    ),
                  ),
                  label: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(Icons.arrow_outward),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
