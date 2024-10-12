import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';
import 'package:instagram_clone/core/widgets/custom_button_widget.dart';

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
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    height: 40,
                    color: AppColors.deepGrey,
                    onPressed: () {},
                    childOfCustomButton: Text(
                      AppStrings.editProfile.tr(),
                      style: CustomTextStyle.pacifico14
                          .copyWith(color: AppColors.lightThemeColor),
                    ),
                  ),
                ),
                const Gap(14),
                Expanded(
                  child: CustomButton(
                    height: 40,
                    color: AppColors.deepGrey,
                    onPressed: () {},
                    childOfCustomButton: Text(
                      AppStrings.shareProfile.tr(),
                      style: CustomTextStyle.pacifico14
                          .copyWith(color: AppColors.lightThemeColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
