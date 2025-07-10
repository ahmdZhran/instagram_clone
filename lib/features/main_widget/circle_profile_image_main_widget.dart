import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/cubits/profile_cubit/profile_cubit.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
  late final ProfileCubit _profileCubit = ProfileCubit.getInstance();

  UserProfileDataModel? currentUserData;

  @override
  void initState() {
    super.initState();
    _fetchUserDataIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserData != null) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.index == 4
                ? context.color.mainColor
                : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.darkGrey,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: currentUserData!.profileImageUrl,
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

    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: _profileCubit,
      builder: (context, state) {
        if (state is ProfileLoading) {
          return LoadingAnimationWidget.beat(
            color: AppColors.primaryColor,
            size: 40,
          );
        } else if (state is ProfileSuccess || state is ProfileUpdateSuccess) {
          final userData = _profileCubit.getCurrentUserProfileData;
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.index == 4
                    ? context.color.mainColor
                    : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: AppColors.darkGrey,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: userData!.profileImageUrl,
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
        return const SizedBox.shrink();
      },
    );
  }

  void _fetchUserDataIfNeeded() {
    if (_profileCubit.getCurrentUserProfileData == null) {
      _profileCubit.getUserData(
        userId: FirebaseAuth.instance.currentUser!.uid,
        isCurrentUser: true,
      );
    }
  }
}
