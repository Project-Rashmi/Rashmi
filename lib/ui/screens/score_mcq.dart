import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rashmi/ui/screens/home_sceen.dart';
import 'package:rashmi/ui/screens/mcq.dart';
import 'package:rashmi/ui/widgets/gradient_text.dart';

class ScoreMcq extends StatelessWidget {
  final int totalCards;
  final int correctAnswers;
  final int deckId;

  const ScoreMcq({
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
              'assets/mcq_quiz.svg',
              fit: BoxFit.cover,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 160),
                    const GradientTextMcq(text: "Your Score"),
                    const SizedBox(height: 60),
                    
                    GradientNumMcq(number: correctAnswers),

                    SvgPicture.asset('assets/line_red.svg'),

                    GradientNumMcq(number: totalCards),

                    const SizedBox(height: 130),

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
                                  builder: (context) => McqQuiz(deckId: deckId),
                                ),
                              );
                            },
                            child: SvgPicture.asset("assets/retry_red.svg"),
                          ),
                          const SizedBox(width: 30),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                            child: SvgPicture.asset("assets/explore.svg"),
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
