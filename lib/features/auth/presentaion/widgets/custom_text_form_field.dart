import 'package:flutter/material.dart';

import '../../../../core/utls/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.onChanged,
  });
  final String hintText;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
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
          onChanged: onChanged,
          cursorHeight: 25,
          cursorColor: AppColors.kBlueColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
