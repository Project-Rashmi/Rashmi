
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rashmi/ui/screens/home_sceen.dart';
import 'package:rashmi/ui/screens/uploadpdf.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,  
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 10, 
            child: SvgPicture.asset(
              'assets/navigation_home.svg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.9, 
            ),
          ),
          Positioned(
            bottom: 25,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadPdf()),
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomBottomNavBarCreate extends StatelessWidget {
  const CustomBottomNavBarCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 20,
            child: SvgPicture.asset(
              'assets/navigation_create.svg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
          ),
          Positioned(
            bottom: 30,
            left: 70,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




/*
class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Text(
          'Selected Page: ${_selectedIndex == 0 ? "Home" : _selectedIndex == 1 ? "Create" : "Explore"}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xff677CFB),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavBarItem(Icons.home, 0, "Home"),
                  _buildNavBarItem(Icons.add, 1, "Create"),
                  _buildNavBarItem(Icons.explore, 2, "Explore"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, int index, String label) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isSelected)
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffF07067),
              ),
            ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
              if (!isSelected)
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
*/