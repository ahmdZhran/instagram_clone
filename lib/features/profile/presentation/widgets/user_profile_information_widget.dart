import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
          title: AppStrings.posts.tr(),
        ),
        UserProfileCountsInfoWidget(
          onTap: () {},
          count: '0',
          title: AppStrings.followers.tr(),
        ),
        UserProfileCountsInfoWidget(
          onTap: () {},
          count: '0',
          title: AppStrings.following.tr(),
        )
      ],
    );
  }
}
