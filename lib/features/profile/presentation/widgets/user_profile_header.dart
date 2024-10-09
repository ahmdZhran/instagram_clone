import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'user_profile_counts_info_widget.dart';

class UserProfileHeaderWidget extends StatelessWidget {
  const UserProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundImage: const AssetImage('assets/images/airen.jpg'),
                ),
                
                const UserProfileInformationWidget()
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
        )
      ],
    );
  }
}
