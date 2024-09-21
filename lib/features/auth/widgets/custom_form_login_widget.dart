import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/extentsions.dart';
import 'package:instagram_clone/core/router/routes.dart';
import 'package:instagram_clone/core/widgets/is_have_an_accout_widget.dart';
import 'package:instagram_clone/features/auth/widgets/padding_wrapper_widget.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_button_widget.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import 'forgot_password_widget.dart';
import 'login_screen_styles.dart';

class CustomFormLogInWidget extends StatelessWidget {
  const CustomFormLogInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PaddingWrapperWidget(
      child: Form(
        child: Column(
          children: [
            const CustomTextFormField(
              hintText: AppStrings.emailAddress,
              keyboardType: TextInputType.emailAddress,
            ),
            const Gap(10),
            const CustomTextFormField(
              obscureText: true,
              hintText: AppStrings.password,
            ),
            const Gap(20),
            const ForgotPasswordWidget(),
            const Gap(20),
            CustomButton(
              childOfCustomButton: const LoginTextStyleP16(),
              onPressed: () {},
              color: AppColors.blueColor,
            ),
            const Gap(30),
            IsHaveAnAccountWidget(
              titleOfTextOne: AppStrings.alreadyHaveAnAccount,
              titleOfTextTwo: AppStrings.signUp,
              onTap: () => context.pushReplacementNamed(Routes.signUp),
            )
          ],
        ),
      ),
    );
  }
}
