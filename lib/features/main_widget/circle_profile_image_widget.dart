import 'package:flutter/material.dart';

class CircleProfileImageWidget extends StatelessWidget {
  const CircleProfileImageWidget({
    super.key,
    required this.widthOfContainer,
    required this.heightOfImage,
    required this.widthOfImage,
    this.margin,
  });
  final double widthOfContainer;
  final double heightOfImage;
  final double widthOfImage;
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
          image: const AssetImage('assets/images/profile_image/profile.png'),
        ),
      )),
    );
  }
}