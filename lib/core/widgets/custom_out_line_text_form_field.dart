import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';

import '../utils/app_colors.dart';

class CustomOutlineTextFormFieldWidget extends StatelessWidget {
  const CustomOutlineTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  final String hintText;
 final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
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
