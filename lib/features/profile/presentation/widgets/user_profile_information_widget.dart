import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';

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
          title: context.translate(AppStrings.posts),
        ),
        UserProfileCountsInfoWidget(
          onTap: () {},
          count: '0',
          title: context.translate(AppStrings.followers),
        ),
        UserProfileCountsInfoWidget(
          onTap: () {},
          count: '0',
          title: context.translate(AppStrings.following),
        )
      ],
    );
  }
}
