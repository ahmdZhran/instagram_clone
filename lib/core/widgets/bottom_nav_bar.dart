import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../utls/app_assets.dart';
import '../utls/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 70,
      border: 0,
      blur: 40,
      borderGradient: const LinearGradient(colors: [Colors.pink, Colors.teal]),
      borderRadius: 20,
      linearGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.1)],
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => onTap(0),
              icon: SvgPicture.asset(
                currentIndex == 0 ? Assets.homeActiveIcon : Assets.homeIcon,
                colorFilter: const ColorFilter.mode(
                  AppColors.kWhiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            IconButton(
              onPressed: () => onTap(1),
              icon: SvgPicture.asset(
                currentIndex == 1 ? Assets.activeSearch : Assets.searchIcon,
                colorFilter: const ColorFilter.mode(
                  AppColors.kWhiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            IconButton(
              onPressed: () => onTap(2),
              icon: SvgPicture.asset(
                Assets.addPost,
              ),
            ),
            IconButton(
              onPressed: () => onTap(3),
              icon: SvgPicture.asset(
                currentIndex == 3 ? Assets.heartActiveIcon : Assets.heartIcon,
                colorFilter: const ColorFilter.mode(
                  AppColors.kWhiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onTap(4),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        currentIndex == 4 ? Colors.white : Colors.transparent,
                    width: 2.0,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage("assets/images/airen.jpg"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
