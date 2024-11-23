import 'package:flutter/material.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/utils/app_strings.dart';

import 'user_profile_counts_info_widget.dart';

class UserProfileInformationWidget extends StatelessWidget {
  const UserProfileInformationWidget({super.key, required this.postsCount});
  final int postsCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserProfileCountsInfoWidget(
          onTap: () {},
          count: postsCount.toString(),
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
