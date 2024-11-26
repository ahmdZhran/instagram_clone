import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_chached_network_image.dart';

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
          child: CustomCachedNetworkImage(
            imageUrl: userProfileImage,
            placeholder: const CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
        ));
  }
}
