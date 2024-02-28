import 'package:flutter/material.dart';

import 'photo_of_profile.dart';
import 'profile_count_widget.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileCountWidget(count: '120', label: 'Following'),
            ProfileAvatarWidget(),
            ProfileCountWidget(count: '21.2k', label: 'Followers'),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Eren_official',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Hero of Attack on Titan',
        ),
        Text(
          'youtube/attack_on_titan/official',
          style: TextStyle(color: Colors.blue),
        ),
      ],
    );
  }
}
