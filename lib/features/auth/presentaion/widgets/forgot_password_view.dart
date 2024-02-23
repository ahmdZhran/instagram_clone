import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/app_colors.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';
import 'package:instagram_clone/core/utls/text_styles.dart';
import 'package:instagram_clone/features/auth/presentaion/widgets/custom_button_widget.dart';
import 'package:instagram_clone/features/auth/presentaion/widgets/custom_text_form_field.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 300),
                  const Text(
                    AppStrings.resetPassword,
                    style: CustomTextStyles.pacifico50Style,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    AppStrings.pleaseenterYourEmail,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  const CustomTextFormField(hintText: AppStrings.emailAddress),
                  const SizedBox(height: 50),
                  CustomButton(
                    onPressed: () {},
                    color: AppColors.kBlueColor,
                    childOfCustomButton: const Text(
                      AppStrings.sendResetPasswordLink,
                      style: TextStyle(color: AppColors.kWhiteColor),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
