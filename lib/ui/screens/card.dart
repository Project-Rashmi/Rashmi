import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rashmi/core/utils/flashcard_service.dart';
import 'package:rashmi/ui/widgets/card_filp_anime.dart';

class PlayingCard extends StatefulWidget {
  final int deckId;

  const PlayingCard({super.key, required this.deckId});

  @override
  State<PlayingCard> createState() => _PlayingCardState();
}

class _PlayingCardState extends State<PlayingCard> {
  List flashcards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFlashcards();
  }

  Future<void> fetchFlashcards() async {
    try {
      var data = await FlashcardService().getFlashcards(widget.deckId);
      setState(() {
        flashcards = data['flashcards'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching flashcards: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : flashcards.isEmpty
                ? const Center(
                    child: Text(
                      'No flashcards available',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),
                  )
                : Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/playing_card.svg',
                        fit: BoxFit.cover,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: CardFlipAnimation(flashcards: flashcards, deckId: widget.deckId),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
