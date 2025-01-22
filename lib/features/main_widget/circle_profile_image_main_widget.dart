import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/models/user_profile_manager.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CircleProfileImageMainWidget extends StatefulWidget {
  const CircleProfileImageMainWidget({super.key, required this.index});

  final int index;

  @override
  State<CircleProfileImageMainWidget> createState() =>
      _CircleProfileImageMainWidgetState();
}

class _CircleProfileImageMainWidgetState
    extends State<CircleProfileImageMainWidget> {
  final UserProfileManager _profileManager = UserProfileManager();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              widget.index == 4 ? context.color.mainColor : Colors.transparent,
          width: 2.0,
        ),
      ),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: AppColors.darkGrey,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: _profileManager.userProfile!.profileImageUrl,
            placeholder: (context, url) => LoadingAnimationWidget.beat(
              color: AppColors.primaryColor,
              size: 40,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
