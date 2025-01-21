import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          
                            const TextField(
                              decoration: InputDecoration(
                                labelText: "username or email",
                                filled: true,  
                                fillColor: Color(0xFFCAD4FF),  
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),  
                                  borderSide: BorderSide.none,  
                                ),
                                labelStyle: TextStyle(
                                  fontSize: 16,  
                                  fontWeight: FontWeight.bold,  
                                  color: Color(0xFF0A1F3E),  
                                ),
                                contentPadding: EdgeInsets.only(left: 16, top: 15, bottom: 15),  
                              ),
                            ),
          
                            const SizedBox(height: 20),
          
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "password",
                                filled: true,  
                                fillColor: Color(0xFFCAD4FF),  
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),  
                                  borderSide: BorderSide.none,  
                                ),
                                labelStyle: TextStyle(
                                  fontSize: 16,  
                                  fontWeight: FontWeight.bold,  
                                  color: Color(0xFF0A1F3E),  
                                ),
                                contentPadding: EdgeInsets.only(left: 16, top: 15, bottom: 15),  
                              ),
                            ),
          
                            const SizedBox(height: 20),
          
                            GestureDetector(
                              onTap: () => {
                                //aba yeta ho tero kaam dalton
                              },
                              child: SvgPicture.asset(
                                'assets/lets_go.svg', 
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          // Yo maile garxu
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