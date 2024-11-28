import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import '../cubits/user_posts/user_posts_cubit.dart';
import 'user_profile_information_widget.dart';

class ProfileImageAndInfo extends StatefulWidget {
  const ProfileImageAndInfo({super.key, required this.profileCubit});
  final ProfileCubit profileCubit;

  @override
  State<ProfileImageAndInfo> createState() => _ProfileImageAndInfoState();
}

class _ProfileImageAndInfoState extends State<ProfileImageAndInfo> {
  final UserPostsCubit _userPostsCubit = UserPostsCubit.getInstance();

  @override
  void initState() {
    _userPostsCubit.postsCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: CircleAvatar(
            radius: 40.r,
            child: CachedNetworkImage(
              imageUrl: widget.profileCubit.userProfileData?.profileImageUrl ??
                  "No image available",
              placeholder: (context, url) => const CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Gap(20),
        UserProfileInformationWidget(
          postsCount: _userPostsCubit.postsCount?.toInt() ?? 0,
            followingCount: widget.profileCubit.userProfileData?.following?.toInt() ?? 0,
           followersCount: widget.profileCubit.userProfileData?.followers?.toInt() ?? 0,
        ),
      ],
    );
  }
}
