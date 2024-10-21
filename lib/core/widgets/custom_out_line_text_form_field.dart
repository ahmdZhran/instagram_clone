import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';

import '../utils/app_colors.dart';

class CustomOutlineTextFormFieldWidget extends StatelessWidget {
  const CustomOutlineTextFormFieldWidget({
    super.key,
    required this.labelName,
    required this.controller,
  });

  final TextEditingController controller;
  final String labelName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        label: Text(
          labelName,
          style: CustomTextStyle.pacifico14.copyWith(
            color: AppColors.greyColor,
          ),
        ),
      ),
    );
  }
}
