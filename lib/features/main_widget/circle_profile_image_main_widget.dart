import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/cubits/profile_cubit/profile_cubit.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CircleProfileImageMainWidget extends StatefulWidget {
  const CircleProfileImageMainWidget(
      {super.key, required this.userId, required this.index});

  final String userId;
  final int index;
  @override
  State<CircleProfileImageMainWidget> createState() =>
      _CircleProfileImageMainWidgetState();
}

class _CircleProfileImageMainWidgetState
    extends State<CircleProfileImageMainWidget> {
  late final ProfileCubit _profileCubit = ProfileCubit.getInstance();

  @override
  void initState() {
    if (_profileCubit.userProfileData == null) {
      _profileCubit.getUserData(userId: widget.userId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: _profileCubit,
      builder: (context, state) {
        if (state is ProfileLoading) {
          LoadingAnimationWidget.beat(
            color: AppColors.primaryColor,
            size: 40,
          );
        } else if (state is ProfileSuccess || state is ProfileUpdateSuccess) {
          final userData = _profileCubit.userProfileData;
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
}
