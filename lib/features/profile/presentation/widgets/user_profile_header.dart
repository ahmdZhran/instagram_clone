import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../cubits/profile_cubit/profile_cubit.dart';

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
        child: BlocBuilder<ProfileCubit, ProfileState>(
          bloc: ProfileCubit.getInstance(),
          builder: (context, state) {
            if (state is ProfileSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                        backgroundImage:
                            Chache(state.userData!.profileImageUrl),
                      ),
                      const UserProfileInformationWidget()
                    ],
                  ),
                  const Gap(40),
                  Text(
                    state.userData!.name,
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
                            context.translate(AppStrings.editProfile),
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
                          childOfCustomButton: AutoSizeText(
                            context.translate(AppStrings.shareProfile),
                            maxLines: 1,
                            style: CustomTextStyle.pacifico13
                                .copyWith(color: AppColors.lightThemeColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
