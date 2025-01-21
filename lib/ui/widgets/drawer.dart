import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rashmi/ui/widgets/drawer_list.dart';

class DrawerWidget extends StatelessWidget{

  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/drawer_background.svg', 
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 200,
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Rashmi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Easy FlashCard App',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomListTile(
                      icon: Icons.person,
                      title: 'Profile',
                      iconColor: const Color(0xff677CFB),
                      textColour: const Color(0xff677CFB),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 18),
                    CustomListTile(
                      icon: Icons.bar_chart,
                      title: 'Stats',
                      iconColor: const Color(0xff677CFB),
                      textColour: const Color(0xff677CFB),
                      onTap: () {
                        Navigator.pop(context);
                      }, 
                    ),
                    const SizedBox(height: 18),
                    CustomListTile(
                      icon: Icons.settings,
                      title: 'Settings',
                      iconColor: const Color(0xff677CFB),
                      textColour: const Color(0xff677CFB),
                      onTap: () {
                        Navigator.pop(context);
                      }
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