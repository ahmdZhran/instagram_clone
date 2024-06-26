import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utls/spacer_helper.dart';
import '../../view_model/profile_cubit/profile_cubit.dart';

import '../../../../../core/utls/app_colors.dart';
import '../../../../../core/widgets/custom_button_widget.dart';
import '../../views/custom_shimmer.dart';
import 'photo_of_profile.dart';
import 'profile_count_widget.dart';

class ProfileInfoWidget extends StatefulWidget {
  const ProfileInfoWidget({Key? key}) : super(key: key);

  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  late ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = BlocProvider.of<ProfileCubit>(context);
    _profileCubit.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInfoLoading) {
          return const Center(
            child: CustomShimmer(),
          );
        } else if (state is ProfileInfoSuccess) {
          final userProfile = state.userProfile;
          return Column(
            children: [
            30.0.getVerticalSpacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileCountWidget(
                      count: (userProfile.following?.length ?? 0).toString(),
                      label: 'Following'),
                  const ProfileAvatarWidget(),
                  ProfileCountWidget(
                      count: (userProfile.followers?.length ?? 0).toString(),
                      label: 'Followers'),
                ],
              ),
              10.0.getVerticalSpacer(),
              Text(
                userProfile.userName.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
             5.0.getVerticalSpacer(),
              Text(
                userProfile.name.toString(),
              ),
             5.0.getVerticalSpacer(),
              Text(
                userProfile.bio.toString(),
              ),
              const Text(
                'youtube/attack_on_titan/official',
                style: TextStyle(color: Colors.blue),
              ),
             10.0.getVerticalSpacer(),
              CustomButton(
                childOfCustomButton: const Text(
                  'Edit Profile',
                  style: TextStyle(color: AppColors.kWhiteColor),
                ),
                height: 40,
                width: 180,
                onPressed: () {
                  // TODO
                },
              )
            ],
          );
        } else if (state is ProfileInfoFailer) {
          return Text(state.errMessage);
        } else {
          return const Center(
              child: Icon(
            Icons.error,
            color: Colors.red,
          ));
        }
      },
    );
  }
}
