import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'user_profile_information_widget.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundImage: const AssetImage('assets/images/airen.jpg'),
                ),
                const UserProfileInformationWidget()
              ],
            ),
            const Gap(40),
            const Text(
              'Ahmed Muhamed',
            ),
            const Gap(10),
            const Text(
              'we just try ',
            )
          ],
        ),
      ),
    );
  }
}
