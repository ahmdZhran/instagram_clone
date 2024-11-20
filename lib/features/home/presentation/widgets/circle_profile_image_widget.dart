import 'package:flutter/material.dart';

class CircleProfileImageWidget extends StatelessWidget {
  const CircleProfileImageWidget({
    super.key,
    required this.userProfileImage,
  });

  final String userProfileImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
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
      child: ClipOval(
        child: Image.network(userProfileImage),
      ),
    );
  }
}
