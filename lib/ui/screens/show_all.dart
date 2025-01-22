import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowAll extends StatefulWidget {
  const ShowAll({Key? key}) : super(key: key);

  @override
  State<ShowAll> createState() => _ShowAllSState();
}

class _ShowAllSState extends State<ShowAll> {
  List<Map<String, dynamic>> cards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllCards();
  }

  Future<void> fetchAllCards() async {
    const String url =
        'https://needed-narwhal-charmed.ngrok-free.app/card/decks';
    const String token =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbjExIiwiZXhwIjoxNzM4MDgwNDQ2LCJpYXQiOjE3Mzc0ODA0NDZ9.4VnIHmq-KeGGxsx7-QapFRBm25t5B3JLXsvxzmw5FKE';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          cards = data.map<Map<String, dynamic>>((card) {
            return {
              'name': card['name'],
              'mcqs': card['mcqs'],
              'flashcards': card['flashcards'],
            };
          }).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch cards');
      }
    } catch (e) {
      debugPrint('Error fetching cards: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Cards",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: cards.length *
                  2, // For each card, we show mcqs and flashcards in alternating columns
              itemBuilder: (BuildContext context, int index) {
                final cardIndex = index ~/ 2; // Each card occupies two cells
                final card = cards[cardIndex];
                final isMcq = index % 2 ==
                    0; // Even index for MCQs, Odd index for Flashcards
                final itemName = isMcq ? 'MCQs' : 'Flashcards';
                final itemCount = isMcq ? card['mcqs'] : card['flashcards'];
                final imageAsset = isMcq
                    ? 'assets/study.svg' // MCQ image
                    : 'assets/study_blue.svg'; // Flashcard image

                return GestureDetector(
                  onTap: () {
                    debugPrint('${card['name']} - $itemName clicked');
                  },
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        imageAsset,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              card['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$itemName: $itemCount',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
