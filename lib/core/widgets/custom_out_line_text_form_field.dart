import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';

import '../utils/app_colors.dart';

class CustomOutlineTextFormFieldWidget extends StatelessWidget {
  const CustomOutlineTextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: CustomTextStyle.pacifico16.copyWith(
          color: context.color.mainColor,
        ),
      ),
    );
  }
}
