import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rashmi/core/utils/flashcard_utils.dart';
import 'package:rashmi/ui/screens/card.dart';
import 'package:rashmi/ui/screens/show_all.dart';
import 'package:rashmi/ui/widgets/bottom_navigation.dart';
import 'package:rashmi/ui/widgets/drawer.dart';
import 'package:rashmi/ui/widgets/progress_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';
  List<String> cardNames = [];
  List<Map<String, dynamic>> cards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // load all data
  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    await Future.wait([
      fetchUsername(),
      fetchCards(),
    ]);

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchUsername() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      username = 'user'; // Replace this with actual username from the server
    });
  }

  Future<void> fetchCards() async {
    const String url =
        'https://needed-narwhal-charmed.ngrok-free.app/card/recent';
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
          cards = data
              .map((card) => {
                    'name': card['name'],
                    'flashcards': card['flashcards'],
                    'mcqs': card['mcqs'],
                    'deckId': card['id'],
                  })
              .toList();
        });
      } else {
        throw Exception('Failed to load cards');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching cards: $e');
      }
    }
  }

  // Pull to refresh function
  Future<void> _handleRefresh() async {
    await _loadData();
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SafeArea(
          child: SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(), // Important for pull-to-refresh to work
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                            icon: SvgPicture.asset(
                              'assets/menu.svg',
                            ),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                              if (kDebugMode) {
                                print(jsonData);
                              }
                            },
                          );
                        },
                      ),
                      SvgPicture.asset(
                        'assets/streak_temp.svg',
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning,\n${username.isNotEmpty ? username : 'Loading...'}!',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const CustomProgressBar(progress: 0.7),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  debugPrint('1 clicked');
                                },
                                child: SvgPicture.asset(
                                  'assets/random_cards.svg',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  debugPrint('2 clicked');
                                },
                                child: SvgPicture.asset(
                                  'assets/warmp_up.svg',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  debugPrint('3 clicked');
                                },
                                child: SvgPicture.asset(
                                  'assets/challenger_card.svg',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  debugPrint('MCQ clicked');
                                },
                                child: SvgPicture.asset(
                                  'assets/mcq.svg',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Continue Studying",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShowAll(),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          "assets/show_all.svg",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : cards.isNotEmpty
                          ? GridView.count(
                              crossAxisCount: 2, // 2 columns
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: cards.isNotEmpty
                                  ? List.generate(
                                      4,
                                      (index) {
                                        final cardIndex = index ~/ 2;
                                        final card = cards[cardIndex];
                                        final isMcq = index % 2 == 0;
                                        final itemName =
                                            isMcq ? 'MCQs' : 'Flashcards';
                                        final itemCount = isMcq
                                            ? card['mcqs']
                                            : card['flashcards'];

                                        final imageAsset = isMcq
                                            ? 'assets/study.svg'
                                            : 'assets/study_blue.svg';
                                        return GestureDetector(
                                          onTap: () {
                                            if (!isMcq) {
                                              final deckId = card[
                                                  'deckId']; 
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => PlayingCard(
                                                      deckId:
                                                          deckId),
                                                ),
                                              );
                                            } else {
                                              debugPrint(
                                                  'MCQs clicked TO DO');
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
                                                left:
                                                    8, // Align text to the left
                                                bottom:
                                                    8, // Align text to the bottom
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start, // Align to the left
                                                  children: [
                                                    Text(
                                                      card['name'],
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      '$itemName: $itemCount',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Color.fromARGB(
                                                            255, 246, 243, 243),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : [
                                      const Center(
                                        child: Text(
                                          'No cards available',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ])
                          // spacing at bottom for pull-to-refresh to work well
                          : const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
