// main_widget.dart

import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/app_assets.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/features/explore/explore_screen.dart';
import 'package:instagram_clone/features/home/presentation/screens/home_screen.dart';
import 'package:instagram_clone/features/profile/profile_screen.dart';
import 'package:instagram_clone/features/reels/reels_screen.dart';
import 'bottom_nav_bar_item_widget.dart';
import 'bottom_nav_bar_svg_icons_widget.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  PageController controller = PageController(initialPage: 0);
  int index = 0;

  void onNavBarTap(int newIndex) {
    if (index != newIndex) {
      controller.jumpToPage(newIndex);
      setState(() {
        index = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                index = value;
              });
            },
            controller: controller,
            children: const [
              HomeScreen(),
              ExploreScreen(),
              ReelsScreen(),
              ProfileScreen(),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                decoration: BoxDecoration(
                  color: AppColors.blueColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BottomNavBarItemWidget(
                      onTap: () => onNavBarTap(0),
                      isActive: index == 0,
                      activeIcon: AppAssets.activeHomeIcon,
                      inactiveIcon: AppAssets.homeIcon,
                    ),
                    BottomNavBarItemWidget(
                      onTap: () => onNavBarTap(1),
                      isActive: index == 1,
                      activeIcon: AppAssets.activeSearch,
                      inactiveIcon: AppAssets.searchIcon,
                    ),
                    InkWell(
                      onTap: () => onNavBarTap(2),
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: index == 2 ? 1.3 : 1,
                        child: const BottomNavBarSvgIconsWidget(
                          asset: AppAssets.addPost,
                        ),
                      ),
                    ),
                    BottomNavBarItemWidget(
                      onTap: () => onNavBarTap(3),
                      isActive: index == 3,
                      activeIcon: AppAssets.heartActiveIcon,
                      inactiveIcon: AppAssets.heartIcon,
                    ),
                    InkWell(
                      onTap: () => onNavBarTap(4),
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: index == 4 ? 1.3 : 1,
                        child: Icon(
                          Icons.home_filled,
                          color: index == 4
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
