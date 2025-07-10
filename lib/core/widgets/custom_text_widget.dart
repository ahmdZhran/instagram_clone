import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/extensions.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({super.key, required this.text, this.style});
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Text(
      context.translate(text),
      style: style,
    );
  }
}
