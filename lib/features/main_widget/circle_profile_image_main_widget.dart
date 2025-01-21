import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/analytics/v3.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/cubits/profile_cubit/profile_cubit.dart';
import '../../core/models/user_profile_manager.dart';
import '../profile/data/models/user_model.dart';

class CircleProfileImageMainWidget extends StatefulWidget {
  const CircleProfileImageMainWidget({super.key, required this.index});

  final int index;

  @override
  State<CircleProfileImageMainWidget> createState() =>
      _CircleProfileImageMainWidgetState();
}

class _CircleProfileImageMainWidgetState
    extends State<CircleProfileImageMainWidget> {
  final userProfile = UserProfileManager().getUserProfile();
  final ProfileCubit _profileCubit = ProfileCubit.getInstance();
  UserProfileDataModel? _userProfileData;
  @override
  void initState() {
    super.initState();
  _fetchUserData();
  }
 Future<void> _fetchUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await _profileCubit.getUserData(userId: userId);
    _userProfileData = _profileCubit.getUserProfileData;
  }
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
            imageUrl: _userProfileData!.profileImageUrl,
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
