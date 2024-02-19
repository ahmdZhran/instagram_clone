import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/text_styles.dart';

import '../../../../core/utls/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
  });
  final String hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.deepGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: TextFormField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          cursorHeight: 25,
          cursorColor: AppColors.kBlueColor,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              suffixIcon: suffixIcon,
              hintStyle: CustomTextStyles.normalTextStyle
                  .copyWith(color: AppColors.kGreyColor)),
        ),
      ),
    );
  }
}
