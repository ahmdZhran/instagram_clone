import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import '../../../core/utils/app_colors.dart';
import 'padding_wrapper_widget.dart';
import '../../../core/router/routes.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_button_widget.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/is_have_an_account_widget.dart';

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
              ),
            ),
            const Gap(20),
            IsHaveAnAccountWidget(
              titleOfTextOne: AppStrings.alreadyHaveAnAccount,
              titleOfTextTwo: AppStrings.logIn,
              onTap: () => context.pushReplacementNamed(Routes.logIn),
            ),
          ],
        ),
      ),
    );
  }
}
