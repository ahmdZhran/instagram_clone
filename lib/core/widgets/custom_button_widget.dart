import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color,
    required this.onPressed,
    this.childOfCustomButton,
    this.width,
    this.height,
    this.isLoading = false,
  });

  final Color? color;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Widget? childOfCustomButton;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: childOfCustomButton,
      ),
    );
  }
}
