import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/app_colors.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';
import 'package:instagram_clone/features/auth/presentaion/widgets/custom_button_widget.dart';

import 'custom_text_form_field.dart';

class CustomFormSignUp extends StatelessWidget {
  const CustomFormSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const CustomTextFormField(
              hintText: AppStrings.fristName,
            ),
            const CustomTextFormField(hintText: AppStrings.lastName),
            const CustomTextFormField(
                hintText: AppStrings.emailAddress,
                keyboardType: TextInputType.emailAddress),
            CustomTextFormField(
              hintText: AppStrings.password,
              obscureText: false,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.visibility_off,
                ),
              ),
            ),
            const SizedBox(height: 15),
            CustomButton(
              onPressed: () {},
              text: AppStrings.signUp,
              color: AppColors.kBlueColor,
            )
          ],
        ),
      ),
    );
  }
}
