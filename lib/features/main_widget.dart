import 'package:flutter/material.dart';
import 'package:instagram_clone/features/explore/explore_screen.dart';
import 'package:instagram_clone/features/home/presentation/screens/home_screen.dart';
import 'package:instagram_clone/features/profile/profile_screen.dart';
import 'package:instagram_clone/features/reels/reels_screen.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  PageController controller = PageController(initialPage: 0);
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: const [
              HomeScreen(),
              ExploreScreen(),
              ReelsScreen(),
              ProfileScreen()
            ],
          )
        ],
      ),
    );
  }
}
