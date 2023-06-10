// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vehicle_tracking_mobile_app/pages/start_tracking.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _showErrorBottomSheet(String errorMessage) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 80, // Set the desired height here
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              errorMessage,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

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
            builder: (context) => const StartTracking(),
          ),
        );
      } else if (response.statusCode == 400) {
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        final errorMessage = errorResponse['error_description'];
        _showErrorBottomSheet(errorMessage);
      } else {
        // Handle other error responses
        print('Error logging in with password grant type');
      }
    } catch (e) {
      print('Error logging in with password grant type: $e');
    }
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      _showErrorBottomSheet('Please Enter Your Email');
      return false;
    }

    if (!email.contains('@')) {
      _showErrorBottomSheet('Invalid email');
      return false;
    }
    return true;
  }

  bool validatePassword(String password) {
    if (password.isEmpty) {
      _showErrorBottomSheet('Please Enter Your Password');
      return false;
    }

    return true;
  }

  void login() {
    final email = _usernameController.text;
    final password = _passwordController.text;

    if (email.isEmpty && password.isEmpty) {
      _showErrorBottomSheet('Please Enter your Email and Password');
      return;
    }

    if (validateEmail(email) && validatePassword(password)) {
      loginWithPasswordGrantType();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Center(
          child: Image.asset(
            'assets/images/vtrack.png',
            height: 40,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 17, 24, 39),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(15)),
              const Center(
                child: Text(
                  "Login to VTrack!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, bottom: 5),
                child: const Center(
                  child: Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 445,
                height: 50,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextFormField(
                    cursorColor: const Color.fromARGB(255, 31, 41, 55),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(237, 236, 236, 1),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(237, 236, 236, 1),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 31, 41, 55),
                        ),
                      ),
                    ),
                    controller: _usernameController,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, bottom: 5),
                child: const Center(
                  child: Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 445,
                height: 50,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    cursorColor: const Color.fromARGB(255, 31, 41, 55),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(237, 236, 236, 1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromRGBO(237, 236, 236, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 31, 41, 55),
                        ),
                      ),
                    ),
                    controller: _passwordController,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: const Color.fromARGB(255, 17, 24, 39),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
