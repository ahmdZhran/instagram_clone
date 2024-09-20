import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';

abstract class CustomTextStyle {
  static final pacifico40 = TextStyle(
    fontSize: 40.sp,
  );
  static final pacifico16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static final pacifico18 = TextStyle(
    fontSize: 18.sp,
    color: AppColors.blueColor,
    fontWeight: FontWeight.bold,
  );
  static final normalTextStyle = TextStyle(
    fontSize: 12.sp,
  );
}
