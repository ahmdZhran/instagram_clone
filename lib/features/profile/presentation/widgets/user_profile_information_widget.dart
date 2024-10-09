import 'package:flutter/material.dart';

import 'user_profile_counts_info_widget.dart';

class UserProfileInformationWidget extends StatelessWidget {
  const UserProfileInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserProfileCountsInfoWidget(
          onTap: () {},
          count: '0',
          title: 'posts',
        ),
        UserProfileCountsInfoWidget(
          onTap: () {},
          count: '0',
          title: 'Followers',
        ),
        UserProfileCountsInfoWidget(
          onTap: () {},
          count: '0',
          title: 'Following',
        )
      ],
    );
  }
}
