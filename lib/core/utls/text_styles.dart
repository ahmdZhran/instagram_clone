import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class CustomTextStyles {
  static final pacifico50Style = TextStyle(
    fontFamily: "Pacifico",
    fontSize: 30.sp,
  );
  static final normalTextStyle = TextStyle(
    fontSize: 12.sp,
    color: AppColors.kWhiteColor,
  );
}
