import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/helper/extensions.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../cubits/profile_cubit/profile_cubit.dart';

class EditAndShareButtonsWidget extends StatelessWidget {
  const EditAndShareButtonsWidget({
    super.key,
    required ProfileCubit profileCubit,
  }) : _profileCubit = profileCubit;

  final ProfileCubit _profileCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          width: 140.w,
          height: 30.h,
          color: AppColors.primaryColor,
          onPressed: () {
            context.pushNamed(
              Routes.editProfileScreen,
              arguments: _profileCubit.userProfileData,
            );
          },
          childOfCustomButton: Text(
            context.translate(AppStrings.editProfile),
            style: CustomTextStyle.pacifico14
                .copyWith(color: AppColors.lightThemeColor),
          ),
        ),
        CustomButton(
          width: 140.w,
          height: 30.h,
          color: AppColors.primaryColor,
          onPressed: () {},
          childOfCustomButton: Text(
            context.translate(AppStrings.shareProfile),
            style: CustomTextStyle.pacifico13
                .copyWith(color: AppColors.lightThemeColor),
          ),
        ),
      ],
    );
  }
}