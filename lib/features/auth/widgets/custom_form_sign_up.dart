import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/features/auth/widgets/padding_wrapper_widget.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_button_widget.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class CustomFormSignUp extends StatelessWidget {
  const CustomFormSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: PaddingWrapperWidget(
        child: Column(
          children: [
            const CustomTextFormField(
              hintText: AppStrings.username,
            ),
            const CustomTextFormField(
              hintText: AppStrings.name,
            ),
            const CustomTextFormField(
              hintText: AppStrings.bio,
            ),
            const CustomTextFormField(
              hintText: AppStrings.emailAddress,
              keyboardType: TextInputType.emailAddress,
            ),
            const CustomTextFormField(
              hintText: AppStrings.password,
            ),
            const Gap(20),
            CustomButton(
                color: AppColors.blueColor,
                onPressed: () {},
                childOfCustomButton: const Text(
                  AppStrings.signUp,
                ))
          ],
        ),
      ),
    );
  }
}
