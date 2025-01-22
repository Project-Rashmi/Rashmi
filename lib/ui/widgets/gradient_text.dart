import 'package:flutter/material.dart';

class GradientNum extends StatelessWidget {
  final int number;

  const GradientNum({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          number.toString(),
          style: TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5 
              ..shader = const LinearGradient(
                colors: [
                  Color(0xff6F83FC),
                  Color(0xff4A57A5),
                ],
              ).createShader(const Rect.fromLTWH(0, 0, 200, 100)),
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xffFFFFFF),
              Color(0xff677CFB),
            ],
          ).createShader(bounds),
          child: Text(
            number.toString(),
            style: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}


class GradientText extends StatelessWidget {
  final String text;

  const GradientText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Stroke effect
        Text(
          text,
          style: TextStyle(
            fontSize: 60,  // Adjust font size as needed
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5  // Thickness of the stroke
              ..shader = const LinearGradient(
                colors: [
                  Color(0xff6F83FC),
                  Color(0xff4A57A5),
                ],
              ).createShader(const Rect.fromLTWH(0, 0, 300, 100)),
          ),
        ),
        // Gradient fill effect
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xffFFFFFF),
              Color(0xff677CFB),
            ],
          ).createShader(bounds),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.white,  // White for gradient to apply
            ),
          ),
        ),
      ],
    );
  }
}


class GradientNumMcq extends StatelessWidget {
  final int number;

  const GradientNumMcq({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          number.toString(),
          style: TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5 
              ..shader = const LinearGradient(
                colors: [
                  Color(0xffFF9130),
                  Color(0xffFF7700),
                ],
              ).createShader(const Rect.fromLTWH(0, 0, 200, 100)),
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xffFFFFFF),
              Color(0xffFF9130),
            ],
          ).createShader(bounds),
          child: Text(
            number.toString(),
            style: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}


class GradientTextMcq extends StatelessWidget {
  final String text;

  const GradientTextMcq({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Stroke effect
        Text(
          text,
          style: TextStyle(
            fontSize: 60,  // Adjust font size as needed
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5  // Thickness of the stroke
              ..shader = const LinearGradient(
                colors: [
                  Color(0xffFF9130),
                  Color(0xffFF7700),
                ],
              ).createShader(const Rect.fromLTWH(0, 0, 300, 100)),
          ),
        ),
        // Gradient fill effect
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xffFFFFFF),
              Color(0xffFF9130),
            ],
          ).createShader(bounds),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.white,  // White for gradient to apply
            ),
          ),
        ),
      ],
    );
  }
}
