import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rashmi/ui/screens/card.dart';

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
              'deckId': card['id'],
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

  Future<void> deleteDeck(String deckId, BuildContext context) async {
    const String urlBase =
        'https://needed-narwhal-charmed.ngrok-free.app/card/deck';
    const String token =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbjExIiwiZXhwIjoxNzM4MTU3MzY1LCJpYXQiOjE3Mzc1NTczNjV9.IlIUaIA-Cq7sOzW7dNT6SDpoWPWeHr6YdFkc27qTlS0';

    try {
      final response = await http.delete(
        Uri.parse('$urlBase/$deckId'),
        headers: {
          'accept': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        // Successfully deleted
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Deck deleted successfully.'),
          ),
        );
      } else {
        // Handle error
        throw Exception('Failed to delete the deck: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error deleting deck: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete deck. Please try again.'),
        ),
      );
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
                    if (!isMcq) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayingCard(
                            deckId: card['deckId'],
                          ),
                        ),
                      );
                    } else {
                      debugPrint('${card['name']} - $itemName clicked TO DO');
                    }
                  },
                  onLongPress: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: const Color.fromRGBO(
                              103, 124, 251, 1),
                          title: const Text(
                            'Delete Deck',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Nunito',
                              color: Colors.white, 
                            ),
                          ),
                          content: Text(
                            'Are you sure you want to delete the deck "${card['name']}"?',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Nunito',
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Nunito', 
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              style: TextButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(
                                    240, 112, 103, 0.8), 
                              ),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Nunito', 
                                  color: Colors.white, 
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirm == true) {
                      final deckId = card['deckId'].toString();
                      await deleteDeck(deckId, context);
                      setState(() {
                        cards.removeWhere((c) => c['deckId'] == card['deckId']);
                      });
                    }
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
