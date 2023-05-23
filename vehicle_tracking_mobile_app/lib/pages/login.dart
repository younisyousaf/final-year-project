// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vehicle_tracking_mobile_app/location/location.dart';
// import 'package:vehicle_tracking_mobile_app/location/car-location.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.all(15)),
              Container(
                margin: EdgeInsets.only(left: 15, bottom: 5),
                child: Text(
                  "Email",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(237, 236, 236, 1),
                      // hintText: "Enter Your Email",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(237, 236, 236, 1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromRGBO(237, 236, 236, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, bottom: 5),
                child: Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(237, 236, 236, 1),
                      // hintText: "Enter Your Password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromRGBO(237, 236, 236, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromRGBO(237, 236, 236, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                width: 385,
                height: 60,
                margin: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 27, 187, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarLocation(),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 50.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                        thickness: 1.3,
                      ),
                    ),
                  ),
                  Text(
                    "or",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 50.0, right: 15.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                        thickness: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 385,
                height: 60,
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: OutlinedButton(
                    onPressed: null,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(
                        width: 2.0,
                        color: Colors.black87,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login with",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                            margin:
                                EdgeInsets.only(bottom: 10, top: 10, left: 10),
                            child:
                                Image.asset('assets/images/Google_logo.png')),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 385,
                height: 60,
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: OutlinedButton(
                    onPressed: null,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(
                        width: 2.0,
                        color: Colors.black87,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login with",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          child: IconButton(
                            icon: Icon(
                              Icons.facebook_sharp,
                              color: Color.fromARGB(255, 5, 24, 236),
                              size: 45.0,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have an Account?",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signup(),
                          ),
                        );
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                            color: Color.fromARGB(255, 27, 187, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
