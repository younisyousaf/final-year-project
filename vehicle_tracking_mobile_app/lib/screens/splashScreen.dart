// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 265, bottom: 20),
            width: 160,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(120),
              ),
              color: Color.fromARGB(255, 27, 187, 1),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          SizedBox(
            // height: 250.0,
            width: 260.0,
            child: Image.asset(
              'assets/images/privateLines-Car-1.png',
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
            height: 50,
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
                  style: TextStyle(fontSize: 18),
                ),
                icon: Icon(Icons.arrow_outward),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
