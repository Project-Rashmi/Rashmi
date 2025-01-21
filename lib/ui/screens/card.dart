import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rashmi/core/utils/flashcard_utils.dart';
import 'package:rashmi/ui/widgets/card_filp_anime.dart';

class PlayingCard extends StatefulWidget {
  const PlayingCard({super.key});

  @override
  State<PlayingCard> createState() => _PlayingCardState();

  
}

class _PlayingCardState extends State<PlayingCard> {
  late FlashcardModel flashCardModel;
  late CardAnimationState cardFlipAnimation;

  @override
  void initState() {
    super.initState();
  
  flashCardModel = FlashcardModel();
  cardFlipAnimation = CardAnimationState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Stack(
          children: [
            SvgPicture.asset(
              'assets/playing_card.svg',
              fit: BoxFit.cover,
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: GestureDetector(
                  onTap: () => {},
                  child: const CardFlipAnimation()
                ),
              )
            ),


            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => {},
                      child: SvgPicture.asset(
                        'assets/back_arrow.svg',
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/cross.svg',
                    ),
                    SvgPicture.asset(
                      'assets/right.svg',
                    ),
                    GestureDetector(
                      onTap: cardFlipAnimation.showNextCard,
                      child: SvgPicture.asset(
                        'assets/front_arrow.svg',
                      ),
                    ),
                  ],
                ),
              )
            ),

            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: GestureDetector(
                  onTap: () => {
                    log("kina na print message")
                  },
                  child: SvgPicture.asset(
                    'assets/exit.svg',
                  ),
                ),
              )
            ),

            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: Text(
                  'Flashcard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
} 