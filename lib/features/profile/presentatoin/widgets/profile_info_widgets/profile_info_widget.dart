import 'package:flutter/material.dart';
import '../../../../../core/utls/app_colors.dart';
import '../../../../../core/utls/spacer.dart';

import '../../../../../core/widgets/custom_button_widget.dart';
import 'photo_of_profile.dart';
import 'profile_count_widget.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
        const Text(
          'Eren_official',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        verticalSpacer(5),
        const Text(
          'Hero of Attack on Titan',
        ),
        const Text(
          'youtube/attack_on_titan/official',
          style: TextStyle(color: Colors.blue),
        ),
        verticalSpacer(10),
        CustomButton(
          childOfCustomButton: const Text(
            'Edite Profile',
            style: TextStyle(color: AppColors.kWhiteColor),
          ),
          height: 40,
          width: 180,
          onPressed: () {},
        )
      ],
    );
  }
}
