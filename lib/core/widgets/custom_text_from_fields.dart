import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.onChanged,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
  });

  final String labelText;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: (value) {
          if (value!.isEmpty) {
            return 'this field is required';
          } else {
            return null;
          }
        },
        onChanged: onChanged,
        style: const TextStyle(color: AppColors.whiteColor),
        decoration: InputDecoration(
            suffixIcon: suffixIcon != null
                ? SizedBox(
                    height: 48.h,
                    width: 48.h,
                    child: suffixIcon,
                  )
                : null,
            filled: true,
            fillColor: const Color(0xff101215),
            enabledBorder: outlineInputBorder(),
            focusedBorder: outlineInputBorder(),
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 14.sp),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  25,
                ),
                borderSide: const BorderSide(color: Colors.red))),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(
      color: AppColors.greyColor,
    ),
  );
}