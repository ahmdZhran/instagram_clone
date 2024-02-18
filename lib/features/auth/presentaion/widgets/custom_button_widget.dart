import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.color,
      required this.onPressed,
      required this.text,
      this.onTap});
  final Color? color;
  final VoidCallback onPressed;
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: CustomTextStyles.normalTextStyle,
        ),
      ),
    );
  }
}
