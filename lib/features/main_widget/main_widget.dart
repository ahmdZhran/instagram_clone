import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/features/notifications/notifications_screen.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_responsive_spacer_helper.dart';
import '../add_post/add_post_screen.dart';
import '../explore/explore_screen.dart';
import '../home/presentation/screens/home_screen.dart';
import '../profile/presentation/screens/profile_screen.dart';
import 'bottom_nav_bar_item_widget.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  PageController controller = PageController(initialPage: 0);
  int index = 0;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
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
            children: [
              const HomeScreen(),
              const ExploreScreen(),
              const AddPostScreen(),
              const NotificationsScreen(),
              ProfileScreen(
                uid: FirebaseAuth.instance.currentUser!.uid,
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: AppResponsiveSpacerHelper.mediumPadding,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      padding: AppResponsiveSpacerHelper.customPadding,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.primaryColor.withOpacity(0.3)
                            : AppColors.greyColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50.r),
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
                          BottomNavBarItemWidget(
                            onTap: () => onNavBarTap(2),
                            isActive: index == 2,
                            activeIcon: AppAssets.activeAddPost,
                            inactiveIcon: AppAssets.addPost,
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
                              scale: index == 4 ? 1.2 : 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: index == 4
                                        ? context.color.mainColor
                                        : Colors.transparent,
                                    width: 2.0,
                                  ),
                                ),
                                child: const CircleAvatar(
                                  radius: 15,
                                  backgroundImage:
                                      AssetImage("assets/images/airen.jpg"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
