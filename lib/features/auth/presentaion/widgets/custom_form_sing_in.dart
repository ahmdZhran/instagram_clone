import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/app_colors.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';
import 'package:instagram_clone/features/auth/presentaion/widgets/custom_button_widget.dart';
import 'custom_text_form_field.dart';
import 'forgot_passowrd_widget.dart';

class CustomFormSignIn extends StatelessWidget {
  const CustomFormSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const CustomTextFormField(
              hintText: AppStrings.emailAddress,
              keyboardType: TextInputType.emailAddress,
            ),
            CustomTextFormField(
              obscureText: true,
              hintText: AppStrings.password,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.visibility_off,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const ForgotPasswordWidget(),
            const SizedBox(height: 40),
            CustomButton(
              onPressed: () {},
              childOfCustomButton: const Text(AppStrings.signIn),
              color: AppColors.kBlueColor,
            ),
          ],
        ),
      ),
    );
  }
}
