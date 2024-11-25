import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/utils/app_colors.dart';

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
          child: CachedNetworkImage(
            imageUrl: userProfileImage,
              placeholder: (context, url) => Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: AppColors.primaryColor,
                size: 40,
              ),
            ),
          ),
        ));
  }
}
