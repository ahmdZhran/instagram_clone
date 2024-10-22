import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../../../core/widgets/custom_out_line_text_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.userProfileData});
  final UserProfileEntity userProfileData;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? name;
  String? username;
  String? bio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: isNotEmpty ? () {} : null,
            icon: Icon(
              size: 30,
              Icons.check,
              color: isNotEmpty
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withOpacity(.4),
            ),
          ),
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
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  const Gap(20),
                  CustomOutlineTextFormFieldWidget(
                    hintText: widget.userProfileData.username,
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                  ),
                  const Gap(20),
                  CustomOutlineTextFormFieldWidget(
                    hintText: widget.userProfileData.bio,
                    onChanged: (value) {
                      setState(() {
                        bio = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool get isNotEmpty {
    return (name?.isNotEmpty ?? false) ||
        (username?.isNotEmpty ?? false) ||
        (bio?.isNotEmpty ?? false);
  }
}
