import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/custom_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.fieldName,
    this.onChanged,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    required this.controller,
    this.fillColor,
  });
  final String hintText;
  final TextEditingController? controller;
  final String? fieldName;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          validator: (value) {
            return value!.isEmpty ? "You have to enter the $fieldName!" : null;
          },
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          cursorHeight: 25,
          controller: controller,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            errorStyle: const TextStyle(color: Colors.red),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: hintText,
            fillColor: fillColor ?? AppColors.darkGrey,
            filled: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintStyle: CustomTextStyle.normalTextStyle.copyWith(
              color: AppColors.greyColor,
            ),
          ),
        ),
      ),
    );
  }
}
