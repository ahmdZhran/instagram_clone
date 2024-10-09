import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarSvgIconsWidget extends StatelessWidget {
  const BottomNavBarSvgIconsWidget({
    super.key,
    required this.asset,
  });
  final String asset;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      width: 18.w,
      height: 18.h,
      asset,
      colorFilter: const ColorFilter.mode(
        Colors.white,
        BlendMode.srcIn,
      ),
    );
  }
}
