import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';

import 'custom_text_form_field.dart';

class CustomFormSignUp extends StatelessWidget {
  const CustomFormSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const CustomTextFormField(hintText: AppStrings.fristName),
          const CustomTextFormField(hintText: AppStrings.lastName),
          const CustomTextFormField(hintText: AppStrings.emailAddress),
          CustomTextFormField(
            hintText: AppStrings.password,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.visibility_off,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
