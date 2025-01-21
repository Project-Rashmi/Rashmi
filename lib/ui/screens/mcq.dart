import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class McqQuiz extends StatelessWidget{
  const McqQuiz({super.key});

  @override

  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/mcq_quiz.svg',
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      'assets/back_arrow.svg',
                    ),
                    SvgPicture.asset(
                      'assets/cross.svg',
                    ),
                    SvgPicture.asset(
                      'assets/right.svg',
                    ),
                    SvgPicture.asset(
                      'assets/front_arrow.svg',
                    ),
                  ],
                ),
              )
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: SvgPicture.asset(
                  'assets/exit.svg',
                ),
              )
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: Text(
                  'MCQs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ),
          ],
        )
      ),
    );
  }
}