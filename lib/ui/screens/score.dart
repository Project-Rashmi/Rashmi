import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rashmi/ui/screens/card.dart';
import 'package:rashmi/ui/screens/mcq.dart';
import 'package:rashmi/ui/widgets/gradient_text.dart';

class ScoreFlashcard extends StatelessWidget {
  final int totalCards;
  final int correctAnswers;
  final int deckId;

  const ScoreFlashcard({
    super.key,
    required this.totalCards,
    required this.correctAnswers,
    required this.deckId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/playing_card.svg',
              fit: BoxFit.cover,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 160),
                    const GradientText(text: "Your Score"),
                    const SizedBox(height: 60),
                    
                    GradientNum(number: correctAnswers),

                    SvgPicture.asset('assets/line.svg'),

                    GradientNum(number: totalCards),

                    const SizedBox(height: 40),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayingCard(deckId: deckId),
                                ),
                              );
                            },
                            child: SvgPicture.asset("assets/retry.svg"),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const McqQuiz(),
                                ),
                              );
                            },
                            child: SvgPicture.asset("assets/play_quiz.svg"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
