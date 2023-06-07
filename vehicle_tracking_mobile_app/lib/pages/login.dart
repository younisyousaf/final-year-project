// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vehicle_tracking_mobile_app/pages/start_tracking.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> loginWithPasswordGrantType() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final Map<String, dynamic> body = {
        'grant_type': 'password',
        'username': username,
        'password': password,
        'client_id': 'vtrack.mobile',
        'scope': 'offline_access IdentityServerApi openid',
        // Include any additional parameters required by your server
      };

      final url = Uri.parse('http://localhost:3001/connect/token');
      final response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final accessToken = jsonResponse['access_token'];
        await secureStorage.write(
            key: 'refresh_token', value: jsonResponse['access_token']);
        await secureStorage.write(
            key: 'access_token', value: jsonResponse['refresh_token']);

        // Handle the access token or any other response data
        print('Access Token: $accessToken');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StartTracking(),
          ),
        );
      } else {
        // Handle the error response
        print('Error logging in with password grant type');
      }
    } catch (e) {
      print('Error logging in with password grant type: $e');
    }
  }

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
                  child: TextFormField(
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
                    controller: _usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the valid email';
                      }
                      return null;
                    },
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
                  child: TextFormField(
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
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the password';
                      }
                      return null;
                    },
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
                  onPressed: () async {
                    await loginWithPasswordGrantType();
                  },
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
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
              // Container(
              //   margin: EdgeInsets.only(top: 30),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         "Don't Have an Account?",
              //         style: TextStyle(
              //           fontSize: 20,
              //           color: Colors.black,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //       TextButton(
              //         onPressed: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => Signup(),
              //             ),
              //           );
              //         },
              //         child: Text(
              //           "Signup",
              //           style: TextStyle(
              //               color: Color.fromARGB(255, 27, 187, 1),
              //               fontSize: 20,
              //               fontWeight: FontWeight.w900),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
