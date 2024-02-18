import 'package:flutter/material.dart';

class CustomHeadText extends StatelessWidget {
  const CustomHeadText({
    super.key,
    required this.text,
    this.style,
  });
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
