import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/profile/presentatoin/view_model/profile_cubit/profile_cubit.dart';

import '../../../../../core/utls/app_colors.dart';
import '../../../../../core/utls/spacer.dart';
import '../../../../../core/widgets/custom_button_widget.dart';
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
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileInfoSuccess) {
          final userProfile = state.userProfile;
          return Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileCountWidget(count: '120', label: 'Following'),
                  ProfileAvatarWidget(),
                  ProfileCountWidget(count: '21.2k', label: 'Followers'),
                ],
              ),
              verticalSpacer(10),
              Text(
                userProfile.userName.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              verticalSpacer(5),
              Text(
                userProfile.name.toString(),
              ),
              verticalSpacer(5),
              Text(
                userProfile.bio.toString(),
              ),
              const Text(
                'youtube/attack_on_titan/official',
                style: TextStyle(color: Colors.blue),
              ),
              verticalSpacer(10),
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
          return const Text("Unexpected Error");
        }
      },
    );
  }
}
