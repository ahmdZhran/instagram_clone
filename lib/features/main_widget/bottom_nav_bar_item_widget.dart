import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/helper/extensions.dart';

enum IconType { svg, png }

class IconBuilderWidget extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final IconType iconType;
  final double? height;
  final double? width;

  const IconBuilderWidget({
    super.key,
    required this.iconPath,
    required this.iconColor,
    required this.iconType,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    switch (iconType) {
      case IconType.svg:
        return SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          height: height ?? 18.h,
          width: width ?? 18.w,
        );
      case IconType.png:
        return Image.asset(
          iconPath,
          height: height ?? 24.h,
          width: width ?? 24.w,
          color: iconColor,
        );
    }
  }
}

class BottomNavBarItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final String activeIcon;
  final String inactiveIcon;
  final Widget? widget;
  final IconType iconType;

  const BottomNavBarItemWidget({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.activeIcon,
    required this.inactiveIcon,
    this.widget,
    this.iconType = IconType.svg,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = context.color.mainColor;
    return InkWell(
      onTap: onTap,
      child: widget ??
          AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: isActive ? 1.2 : 1,
            child: IconBuilderWidget(
              iconPath: isActive ? activeIcon : inactiveIcon,
              iconColor: iconColor,
              iconType: iconType,
            ),
          ),
    );
  }
}
