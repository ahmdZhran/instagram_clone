import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/bottom_nav_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          Icon(Icons.home),
          Icon(Icons.search),
          Icon(Icons.add_a_photo),
          Icon(Icons.add_a_photo),
          Icon(Icons.person_outlined),
        ],
      ),
    );
  }
}
