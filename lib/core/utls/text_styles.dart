import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/app_colors.dart';

abstract class CustomTextStyles {
  static const instagramFontStyle = TextStyle(
    fontFamily: "Pacifico",
    fontSize: 50,
  );
  static const normalTextStyle = TextStyle(
    fontSize: 14,
    color: AppColors.kWhiteColor,
  );
}
