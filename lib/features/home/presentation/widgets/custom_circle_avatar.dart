import 'package:flutter/material.dart';

class CustomCircularAvatar extends StatelessWidget {
  const CustomCircularAvatar({
    super.key,
    required this.widthOfContainer,
    required this.size,
    required this.assetName,
    this.margin,
  });
  final double widthOfContainer;
  final double size;
  final String assetName;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: CircleAvatar(
          child: ClipOval(
        child: Image(
          height: size,
          width: size,
          fit: BoxFit.cover,
          image: NetworkImage(assetName),
        ),
      )),
    );
  }
}
