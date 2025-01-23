import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:rashmi/ui/screens/score_mcq.dart';

class McqQuiz extends StatefulWidget {
  final int deckId;

  const McqQuiz({super.key, required this.deckId});

  @override
  _McqQuizState createState() => _McqQuizState();
}

class _McqQuizState extends State<McqQuiz> {
  List<dynamic> mcqs = [];
  int currentIndex = 0;
  int correctAnswers = 0;
  int selectedOption = -1;

  @override
  void initState() {
    super.initState();
    fetchMcqs();
  }

  Future<void> fetchMcqs() async {
    final response = await http.get(
      Uri.parse('https://needed-narwhal-charmed.ngrok-free.app/card/deck/${widget.deckId}/mcqs'),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJsb2wiLCJleHAiOjE3MzgxMjk4NTIsImlhdCI6MTczNzUyOTg1Mn0.1zFCpmZLQaauLXtGWlaGnwZ7sZfwZnYskgA1qL07y-I',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        mcqs = jsonDecode(response.body)['mcqs'];
      });
    } else {
      throw Exception('Failed to load MCQs');
    }
  }

    void nextQuestion() {
    if (selectedOption == mcqs[currentIndex]['correct_answer']) {
      correctAnswers++;
    }
    if (currentIndex < mcqs.length - 1) {
      setState(() {
        currentIndex++;
        selectedOption = -1;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreMcq(totalCards: currentIndex+1, correctAnswers: correctAnswers , deckId: widget.deckId),
        ),
      );
    }
  }

  void showScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text('Score: $correctAnswers/${mcqs.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                currentIndex = 0;
                correctAnswers = 0;
                selectedOption = -1;
              });
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

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
          Padding(
            padding: const EdgeInsets.all(35),
            child: mcqs.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'MCQs',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        mcqs[currentIndex]['question'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: List.generate(
                          mcqs[currentIndex]['options'].length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOption = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10.0),
                              padding: const EdgeInsets.all(12.0),
                              decoration: const BoxDecoration(
                                 color: Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    selectedOption == index
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: selectedOption == index
                                        ? Colors.white
                                        : Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      mcqs[currentIndex]['options'][index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
              child: ElevatedButton(
                onPressed: selectedOption == -1 ? null : nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedOption == -1 ? Colors.grey : const Color(0xFFF6F6F6), // Change color based on state
                  foregroundColor: const Color(0xFF677CFB), // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding for better touch area
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  elevation: 5, // Shadow effect
                  textStyle: const TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Wrap content
                  children: [
                    const Text('Next'),
                    const SizedBox(width: 10), // Space between text and icon
                    Icon(Icons.arrow_forward, color: selectedOption == -1 ? Colors.grey[400] : const Color(0xFF677CFB)),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: SvgPicture.asset(
                'assets/exit.svg',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}
