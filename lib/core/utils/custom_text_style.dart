import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';

abstract class CustomTextStyle {
  static final pacifico40 = TextStyle(
    fontSize: 40.sp,
  );
  static final pacifico14 = TextStyle(
    color: AppColors.whiteColor,
    fontSize: 14.sp,
  );
  static final pacifico16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static final pacifico20 = TextStyle(
    fontSize: 20.sp,
  );
  static final pacifico30 = TextStyle(
    fontSize: 30.sp,
  );
  static final pacifico25 = TextStyle(
    fontSize: 25.sp,
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
