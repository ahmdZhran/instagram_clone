import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/custom_text_style.dart';

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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          validator: (value) {
            return value!.isEmpty ? "This Field is required!" : null;
          },
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          cursorHeight: 25,
          cursorColor: AppColors.blueColor,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            errorStyle: const TextStyle(color: Colors.red),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: hintText,
            fillColor: const Color(0x0ffafafa),
            filled: true,
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
