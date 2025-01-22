import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For encoding data to JSON
import 'package:rashmi/ui/screens/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final Map<String, dynamic> requestBody = {
      'username': username,
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('https://needed-narwhal-charmed.ngrok-free.app/auth/register'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode % 200 < 99) {
      final responseData = json.decode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
      print('Registration successful: $responseData');
    } else {
      final errorData = response.body;
      print('Registration failed: $errorData');
    }
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Register",
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
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: "username",
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
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "email",
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
                          controller: _passwordController,
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
                          onTap: _register, // Trigger the API request
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
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have Rashmi?",
                          style: TextStyle(
                            color: Color(0xFF0A1F3E),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Hop here",
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