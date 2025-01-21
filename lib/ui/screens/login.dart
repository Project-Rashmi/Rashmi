import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:rashmi/ui/screens/home_sceen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rashmi/ui/screens/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Show a dialog based on the success or failure of the login
  void showLoginResultDialog(String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isSuccess ? 'Login Successful' : 'Login Failed'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> login() async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      showLoginResultDialog('Username or password cannot be empty', false);
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://needed-narwhal-charmed.ngrok-free.app/auth/login'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'accept': 'application/json',
        },
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String token = data['access_token'];
        print('Token: $token');

        // Save the token locally
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('username', username);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );

        showLoginResultDialog('Login successful! Welcome $username.', true);

        // Optionally, navigate to another screen after login
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        final errorData = jsonDecode(response.body);
        showLoginResultDialog(
            'Login failed: ${errorData['detail'] ?? 'Unknown error'}', false);
      }
    } catch (e) {
      showLoginResultDialog('Error: $e', false);
    }
  }

  Future<Map<String, String?>> getStoredValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the stored username and token
    String? token = prefs.getString('auth_token');
    String? username = prefs.getString('username');

    // Return the values as a Map
    return {
      'username': username,
      'token': token,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: SvgPicture.asset(
                      'assets/login_back_new.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            SvgPicture.asset(
                              'assets/login_vector.svg',
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            labelText: "username or email",
                            filled: true,
                            fillColor: Color(0xFFCAD4FF),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide.none,
                            ),
                            labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0A1F3E),
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 16, top: 15, bottom: 15),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "password",
                            filled: true,
                            fillColor: Color(0xFFCAD4FF),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide.none,
                            ),
                            labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0A1F3E),
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 16, top: 15, bottom: 15),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            // Call the login function
                            await login();

                            // After login, retrieve the stored values
                            Map<String, String?> storedValues =
                                await getStoredValues();

                            // Print the stored values for debugging
                            print(
                                'Stored Username: ${storedValues['username']}');
                            print('Stored Token: ${storedValues['token']}');

                            // Optionally, navigate to another screen after login
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                          },
                          child: SvgPicture.asset(
                            'assets/lets_go.svg',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New to Rashmi?",
                          style: TextStyle(
                            color: Color(0xFF0A1F3E),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Begin here",
                          style: TextStyle(
                            color: Color(0xFF4A57A5),
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
