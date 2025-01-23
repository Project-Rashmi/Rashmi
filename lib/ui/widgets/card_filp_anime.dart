import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rashmi/ui/screens/score_flashcard.dart';

class CardFlipAnimation extends StatefulWidget {
  final List flashcards;
  final int deckId;

  const CardFlipAnimation({super.key, required this.deckId, required this.flashcards});

  @override
  State<CardFlipAnimation> createState() => CardAnimationState();
}

class CardAnimationState extends State<CardFlipAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int currentIndex = 0;
  bool _isFront = true;
  int correctAnswers = 0;
  int wrongAnswers = 0;

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
  }

  void showNextCard() {
    if (currentIndex < widget.flashcards.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreFlashcard(totalCards: currentIndex+1, correctAnswers: correctAnswers , deckId: widget.deckId),
        ),
      );
    }
  }

  void showPreviousCard() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void markCorrect() {
    correctAnswers++;
    showNextCard();
  }

  void markWrong() {
    wrongAnswers++;
    showNextCard();
  }

  void _flipCard() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _isFront = !_isFront;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flashcards.isEmpty) {
      return const Center(
        child: Text(
          'No flashcards to display',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      );
    }

    final card = widget.flashcards[currentIndex];

    return Column(
      children: [
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: _flipCard,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(_animation.value * math.pi),
                child: _animation.value <= 0.5
                    ? _buildFront(card)
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: _buildBack(card),
                      ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: showPreviousCard,
                child: SvgPicture.asset('assets/back_arrow.svg'),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: markWrong,
                child: SvgPicture.asset('assets/cross.svg'),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: markCorrect,
                child: SvgPicture.asset('assets/right.svg'),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: showNextCard,
                child: SvgPicture.asset('assets/front_arrow.svg'),
              ),
            ],
          ),
        ),
      ],
    );
  }



  Widget _buildFront(Map<String, dynamic> card) {
    return _buildCardContent(card['front']);
  }

  Widget _buildBack(Map<String, dynamic> card) {
    return _buildCardContent(card['back']);
  }

Widget _buildCardContent(String text) {
  return LayoutBuilder(
    builder: (context, constraints) {
      double maxSvgHeight = constraints.maxHeight * 0.9; // Use most of available height
      double minFontSize = 18;  // Set a minimum font size for readability
      double maxFontSize = maxSvgHeight * 0.02; // Scale font size proportionally
      double finalFontSize = maxFontSize > minFontSize ? maxFontSize : minFontSize;

      return Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/flip.svg',
            height: maxSvgHeight,
            fit: BoxFit.contain,
          ),
          Positioned(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: finalFontSize, // Adaptive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 5,  // Allow up to 5 lines to balance text wrapping
                  overflow: TextOverflow.ellipsis, // Handle overflow gracefully
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}



}
