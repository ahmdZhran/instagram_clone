import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';
import 'package:instagram_clone/features/profile/domain/entities/user_profile_entity.dart';

import '../../../../core/widgets/custom_out_line_text_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.userProfileData});
  final UserProfileEntity userProfileData;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              size: 30,
              Icons.check,
              color: AppColors.primaryColor,
            ),
          )
        ],
        title: Text(
          context.translate(AppStrings.editProfile),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(widget.userProfileData.profileImageUrl),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      context.translate(AppStrings.changePhoto),
                      style: CustomTextStyle.pacifico18,
                    ),
                  ),
                  CustomOutlineTextFormFieldWidget(
                    hintText: widget.userProfileData.name,
                    onChanged: (name) {},
                  ),
                  const Gap(20),
                  CustomOutlineTextFormFieldWidget(
                    hintText: widget.userProfileData.username,
                    onChanged: (username) {},
                  ),
                  const Gap(20),
                  CustomOutlineTextFormFieldWidget(
                    hintText: widget.userProfileData.bio,
                    onChanged: (bio) {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
