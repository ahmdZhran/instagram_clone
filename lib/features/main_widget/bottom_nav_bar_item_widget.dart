import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';

class BottomNavBarItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final String activeIcon;
  final String inactiveIcon;

  const BottomNavBarItemWidget({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: isActive ? 1.3 : 1,
        child: SvgPicture.asset(
          colorFilter:
              const ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
          height: 18.h,
          width: 18.w,
          isActive ? activeIcon : inactiveIcon,
        ),
      ),
    );
  }
}
