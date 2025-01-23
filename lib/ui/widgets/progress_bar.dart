import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress; // Progress value chai 0.0 and 1.0 ko bich ma huncha

  const CustomProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xffD0D8F8), 
          borderRadius: BorderRadius.circular(20), 
        ),
                ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0), 
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double maxWidth = constraints.maxWidth - 16; 
              return Container(
              height: 23,
              width: maxWidth * progress,
                decoration: BoxDecoration(
                color: const Color(0xffF07067), 
                borderRadius: BorderRadius.circular(14.5),
        ),
      );
    },
  ),
),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 8),
              Text(
               'Goals', 
                style: TextStyle(
                color:  Color(0xffD0D8F8), 
                fontWeight: FontWeight.bold,
              ),
                            ),
            ],
          ),
        ),
      ],
    );
  }
}
