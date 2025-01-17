import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/cubits/profile_cubit/profile_cubit.dart';
import '../../core/helper/extensions.dart';
import '../notifications/notifications_screen.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_responsive_spacer_helper.dart';
import '../posts/presentation/screens/add_post_screen.dart';
import '../explore/presentation/screens/explore_screen.dart';
import '../home/presentation/screens/home_screen.dart';
import '../profile/presentation/screens/profile_screen.dart';
import 'bottom_nav_bar_item_widget.dart';
import 'circle_profile_image_main_widget.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int index = 0;
  final String? uid = FirebaseAuth.instance.currentUser!.uid;
  final ProfileCubit _profileCubit = ProfileCubit.getInstance();

  @override
  void initState() {
    _profileCubit.getUserData(userId: uid!);
    super.initState();
  }

  Widget _getSelectedScreen() {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ExploreScreen();
      case 2:
        return const AddPostScreen();
      case 3:
        return const NotificationsScreen();
      case 4:
        return ProfileScreen(uid: uid!);
      default:
        return const HomeScreen();
    }
  }

  Future<void> _onWillPop() async {
    if (index != 0) {
      setState(() {
        index = 0;
      });
    } else {
      context.showExitConfirmationDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        _onWillPop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _getSelectedScreen(),
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
                          color: AppColors.greyColor.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BottomNavBarItemWidget(
                              onTap: () => setState(() => index = 0),
                              isActive: index == 0,
                              activeIcon: AppAssets.activeHomeIcon,
                              inactiveIcon: AppAssets.homeIcon,
                            ),
                            BottomNavBarItemWidget(
                              onTap: () => setState(() => index = 1),
                              isActive: index == 1,
                              activeIcon: AppAssets.activeSearch,
                              inactiveIcon: AppAssets.searchIcon,
                            ),
                            BottomNavBarItemWidget(
                              onTap: () => setState(() => index = 2),
                              isActive: index == 2,
                              activeIcon: AppAssets.activeAddPost,
                              inactiveIcon: AppAssets.addPost,
                            ),
                            BottomNavBarItemWidget(
                              onTap: () => setState(() => index = 3),
                              isActive: index == 3,
                              activeIcon: AppAssets.heartActiveIcon,
                              inactiveIcon: AppAssets.heartIcon,
                            ),
                            InkWell(
                              onTap: () => setState(() => index = 4),
                              child: AnimatedScale(
                                duration: const Duration(milliseconds: 200),
                                scale: index == 4 ? 1.2 : 1,
                                child:
                                    CircleProfileImageMainWidget(index: index),
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
      ),
    );
  }
}
