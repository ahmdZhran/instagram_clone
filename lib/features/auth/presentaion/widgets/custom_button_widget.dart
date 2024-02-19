import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color,
    required this.onPressed,
    this.childOfCustomButton,
  });
  final Color? color;
  final VoidCallback onPressed;
  final Widget? childOfCustomButton;
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
        child: childOfCustomButton,
      ),
    );
  }
}
