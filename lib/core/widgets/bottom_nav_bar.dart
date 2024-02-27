import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:instagram_clone/core/utls/app_assets.dart';
import 'package:instagram_clone/core/utls/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

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
                Assets.homeIcon,
                colorFilter: const ColorFilter.mode(
                  AppColors.kWhiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            IconButton(
              onPressed: () => onTap(1),
              icon: Image.asset(
                Assets.activeSearch,
                color: AppColors.kWhiteColor,
              ),
            ),
            IconButton(
              onPressed: () => onTap(2),
              icon: const Icon(Icons.post_add),
            ),
            IconButton(
                onPressed: () => onTap(3),
                icon: SvgPicture.asset(Assets.heartIcon)),
            IconButton(
              onPressed: () => onTap(3),
              icon: const Icon(Icons.person_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
