import 'package:flutter/material.dart';

class CustomCircularAvatar extends StatelessWidget {
  const CustomCircularAvatar({
    super.key,
    required this.widthOfContainer,
    required this.heightOfImage,
    required this.widthOfImage,
    required this.assetName,
    this.margin,
  });
  final double widthOfContainer;
  final double heightOfImage;
  final double widthOfImage;
  final String assetName;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: widthOfContainer,
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
          height: heightOfImage,
          width: widthOfImage,
          fit: BoxFit.cover,
          image: const AssetImage(),
        ),
      )),
    );
  }
}
