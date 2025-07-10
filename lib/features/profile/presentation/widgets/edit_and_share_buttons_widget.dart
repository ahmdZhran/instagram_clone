import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/cubits/profile_cubit/profile_cubit.dart';

class EditAndShareButtonsWidget extends StatefulWidget {
  const EditAndShareButtonsWidget({
    super.key,
    required ProfileCubit profileCubit,
    required this.uid,
  }) : _profileCubit = profileCubit;
  final String uid;
  final ProfileCubit _profileCubit;

  @override
  State<EditAndShareButtonsWidget> createState() =>
      _EditAndShareButtonsWidgetState();
}

class _EditAndShareButtonsWidgetState extends State<EditAndShareButtonsWidget> {
  bool isTapped = false;

  @override
  void initState() {
    super.initState();
    isTapped = widget._profileCubit.userProfileData?.followers
            .toString()
            .contains(FirebaseAuth.instance.currentUser!.uid) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      bloc: widget._profileCubit,
      listener: (context, state) {
        if (state is ProfileFollowUpdated) {
          setState(() {
            isTapped = state.isFollowed;
          });
        }
      },
      child: widget.uid == FirebaseAuth.instance.currentUser!.uid
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  width: 140.w,
                  height: 30.h,
                  color: AppColors.primaryColor,
                  onPressed: () {
                    context.pushNamed(
                      Routes.editProfileScreen,
                      arguments: widget._profileCubit.userProfileData,
                    );
                  },
                  childOfCustomButton: Text(
                    context.translate(AppStrings.editProfile),
                    style: CustomTextStyle.pacifico14
                        .copyWith(color: AppColors.lightThemeColor),
                  ),
                ),
                CustomButton(
                  width: 140.w,
                  height: 30.h,
                  color: AppColors.primaryColor,
                  onPressed: () {},
                  childOfCustomButton: Text(
                    context.translate(AppStrings.shareProfile),
                    style: CustomTextStyle.pacifico13
                        .copyWith(color: AppColors.lightThemeColor),
                  ),
                ),
              ],
            )
          : CustomButton(
              width: double.infinity,
              height: 30.h,
              color: AppColors.primaryColor,
              onPressed: () {
                if (isTapped) {
                  widget._profileCubit
                      .unFollowUser(FirebaseAuth.instance.currentUser!.uid, widget.uid);
                } else {
                  widget._profileCubit
                      .followUser(FirebaseAuth.instance.currentUser!.uid, widget.uid);
                }
              },
              childOfCustomButton: Text(
                isTapped
                    ? context.translate(AppStrings.unFollow)
                    : context.translate(AppStrings.follow),
                style: CustomTextStyle.pacifico13
                    .copyWith(color: AppColors.lightThemeColor),
              ),
            ),
    );
  }
}
