import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import '../../features/add_post/presentation/views/add_post.dart';
import '../../features/home/presentation/views/home.dart';
import '../../features/profile/presentatoin/views/profile_view.dart';
import '../../features/search/presentation/views/search_view.dart';
import '../../features/shorts/presentation/views/shorts.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;

  String? doucumentId;
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
          HomeView(),
          SearchView(),
          AddPost(),
          ShortView(),
          ProfileView()
        ],
      ),
    );
  }
}
