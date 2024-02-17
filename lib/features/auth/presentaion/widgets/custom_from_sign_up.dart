import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utls/app_strings.dart';

import 'custom_text_form_field.dart';

class CustomFormSignUp extends StatelessWidget {
  const CustomFormSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Column(
        children: [
          CustomTextFormField(hintText: AppStrings.fristName),
        ],
      ),
    );
  }
}
