import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppResponsiveSpacerHelper {
  static final EdgeInsets smallPadding = EdgeInsets.all(8.w);
  static final EdgeInsets smallSymmetricPadding =
      EdgeInsets.symmetric(horizontal: 10.w);
  static final EdgeInsets smallPaddingOnly =
      EdgeInsets.only(top: 10.h, left: 10, right: 10);
  static final EdgeInsets mediumPadding = EdgeInsets.all(16.w);
  static final EdgeInsets largePadding = EdgeInsets.all(24.w);

  static final EdgeInsets mediumMargin = EdgeInsets.symmetric(horizontal: 16.w);

  static final EdgeInsets horizontalPadding =
      EdgeInsets.symmetric(horizontal: 20.w);
  static final EdgeInsets verticalPadding =
      EdgeInsets.symmetric(vertical: 18.h);

  static final EdgeInsets customPadding = EdgeInsets.symmetric(
    horizontal: 30.w,
    vertical: 14.h,
  );
}
