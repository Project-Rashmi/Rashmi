import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColour;

  const CustomListTile({super.key, 
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.textColour,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color:  Color(0xff4A57A5),
                blurRadius: 0,
                spreadRadius: 0,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColour,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
