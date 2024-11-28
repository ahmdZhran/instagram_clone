import 'package:flutter/material.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/utils/app_strings.dart';

import 'user_profile_counts_info_widget.dart';

class UserProfileInformationWidget extends StatelessWidget {
  const UserProfileInformationWidget(
      {super.key,
      required this.postsCount,
      required this.followersCount,
      required this.followingCount});
  final int postsCount;
  final int followersCount;
  final int followingCount;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            UserProfileCountsInfoWidget(
              onTap: () {},
              count: postsCount.toString(),
              title: context.translate(AppStrings.posts),
            ),
            UserProfileCountsInfoWidget(
              onTap: () {},
              count: followersCount.toString(),
              title: context.translate(AppStrings.followers),
            ),
            UserProfileCountsInfoWidget(
              onTap: () {},
              count: followingCount.toString(),
              title: context.translate(AppStrings.following),
            )
          ],
        ),
      ],
    );
  }
}
