import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/svg.dart';
import 'package:rashmi/core/constants.dart';
import 'package:rashmi/core/utils/flashcard_utils.dart';

class CardFlipAnimation extends StatefulWidget {
	const CardFlipAnimation({super.key});

	@override
	createState() => CardAnimationState();

  
}

class CardAnimationState extends State<CardFlipAnimation> with SingleTickerProviderStateMixin {
      late AnimationController _controller;
      late Animation<double> _animation;
      late FlashcardModel flashCardModel;
      // Flashcard? tempFlashCard;
      late List flashcards;
      int currentIndex = 0;
      bool _isFront = true;
 
      @override
      void initState() {
        super.initState();
        _controller = AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 500),
        );

        _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
          ..addListener(() {
            setState(() {});
          });

        //flashCardModel = FlashcardModel();

        final parsedJson = jsonDecode(jsonString);
        flashcards = parsedJson['flashcards'];
      }

        void showNextCard() {
          if (mounted) {
            setState(() {
              currentIndex = (currentIndex + 1) % flashcards.length;
              print("Current Index: $currentIndex");
              print("Current Flashcard: ${flashcards[currentIndex]}");
            });
          }
        }


      @override
      void dispose() {
        _controller.dispose();
        super.dispose();
      }

      // void onFrontTapped() {
      //   tempFlashCard = flashCardModel.onFrontMCQClicked();
      // }
 
      void _flipCard() {
        if (_controller.status != AnimationStatus.forward) {
              if (_isFront) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
              _isFront = !_isFront;
        }
      }

      

       @override
      Widget build(BuildContext context) {

        return Scaffold(
          backgroundColor: Colors.transparent,
              body: GestureDetector(
                onTap: _flipCard,
                child: Center(
                      child: FittedBox(
                        child: Transform(
                              transform: Matrix4.rotationY(_animation.value * math.pi),
                              alignment: Alignment.center,
                              child: _isFront ? _buildFront() : _buildBack(),
                        ),
                      ),
                ),
              ),
        );
      }

      Widget _buildFront() {

        final card = flashcards[currentIndex];

        return ClipRRect(
          child: SizedBox(
            width: 339,
            height: 213,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/flip.svg',
                  fit: BoxFit.contain,
                ),
            
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      //tempFlashCard?.front??'',
                      card['front'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
 
      Widget _buildBack() {

        final card = flashcards[currentIndex];

        return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14),
              child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                'assets/flip.svg',
              ),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      //tempFlashCard?.front??'',
                      card['back'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                    ),
                  ),
                ),
            ],
          ),
        );
      }
}