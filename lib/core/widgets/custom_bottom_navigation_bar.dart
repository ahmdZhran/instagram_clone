import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/bottom_nav_bar.dart';
import 'package:instagram_clone/features/add_post/presentation/views/add_post.dart';
import 'package:instagram_clone/features/home/presentation/views/home.dart';
import 'package:instagram_clone/features/profile/presentatoin/views/profile.dart';
import 'package:instagram_clone/features/search/presentation/views/search_view.dart';
import 'package:instagram_clone/features/shorts/presentation/views/shorts.dart';

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
