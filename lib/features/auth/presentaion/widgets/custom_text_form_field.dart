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
          cursorColor: AppColors.kBlueColor,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            errorStyle: const TextStyle(color: Colors.red),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius:
                  BorderRadius.circular(20), // Set circular border radius
            ),
            hintText: hintText,
            fillColor: AppColors.deepGrey,
            filled: true,
            suffixIcon: suffixIcon,
            hintStyle: CustomTextStyles.normalTextStyle.copyWith(
              color: AppColors.kGreyColor,
            ),
          ),
        ),
      ),
    );
  }
}
