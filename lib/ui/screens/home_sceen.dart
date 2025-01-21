import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rashmi/core/utils/flashcard_utils.dart';
import 'package:rashmi/ui/widgets/bottom_navigation.dart';
import 'package:rashmi/ui/widgets/drawer.dart';
import 'package:rashmi/ui/widgets/progress_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    drawer: const DrawerWidget(),
    body: SafeArea(
      child: SingleChildScrollView(
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
              const Text(
                'Good Morning,\nRashmi!',
                style: TextStyle(
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
                      debugPrint('View All clicked');
                    },
                    child: SvgPicture.asset(
                      "assets/show_all.svg",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () => {},
                    child: SvgPicture.asset(
                      'assets/study.svg',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {},
                    child: SvgPicture.asset(
                      'assets/study_blue.svg',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {},
                    child: SvgPicture.asset(
                      'assets/study.svg',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {},
                    child: SvgPicture.asset(
                      'assets/study_blue.svg',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
    bottomNavigationBar: const CustomBottomNavBar(),
  );
}
}
